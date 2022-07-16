defmodule GenLSPTest do
  use ExUnit.Case
  alias GenLSP.Protocol.Requests
  alias GenLSP.Protocol.Notifications
  alias GenLSP.Protocol.Structures

  defmodule TestWire do
    use GenServer

    # require Logger

    def init, do: :ok

    def start_link(test_pid) do
      GenServer.start_link(__MODULE__, test_pid, name: __MODULE__)
    end

    def init(test_pid) do
      {:ok, %{test_pid: test_pid, messages: [], awaiting: []}}
    end

    def write(body) do
      GenServer.call(__MODULE__, {:write, body})
    end

    def read do
      GenServer.call(__MODULE__, :read)
    end

    def client_write(body) do
      GenServer.call(__MODULE__, {:client_write, body})
    end

    def handle_call({:write, body}, _from, state) do
      # Logger.debug("[TestWire] write")
      send(state.test_pid, {:wire, body})
      {:reply, :ok, state}
    end

    def handle_call(:read, _from, %{messages: [message | rest]} = state) do
      # Logger.debug("[TestWire] read: has messages")
      {:reply, {:ok, message}, %{state | messages: rest}}
    end

    def handle_call(:read, from, %{messages: [], awaiting: awaiting} = state) do
      # Logger.debug("[TestWire] read: no messages")
      {:noreply, %{state | awaiting: [from | awaiting]}}
    end

    def handle_call({:client_write, body}, _from, %{awaiting: [_ | _]} = state) do
      # Logger.debug("[TestWire] client_write: awaiting")

      for pid <- state.awaiting do
        GenServer.reply(pid, {:ok, body})
      end

      {:reply, :ok, state}
    end

    def handle_call({:client_write, body}, _from, %{messages: messages} = state) do
      # Logger.debug("[TestWire] client_write")
      {:reply, :ok, %{state | messages: messages ++ [body]}}
    end
  end

  defmodule ExampleServer do
    use GenLSP

    alias GenLSP.Protocol.Requests
    alias GenLSP.Protocol.Notifications
    alias GenLSP.Protocol.Structures

    def start_link(opts) do
      {test_pid, opts} = Keyword.pop(opts, :test_pid)
      GenLSP.start_link(__MODULE__, test_pid, opts)
    end

    @impl true
    def init(test_pid) do
      {:ok, %{foo: :bar, test_pid: test_pid}}
    end

    @impl true
    def handle_request(%Requests.Initialize{id: id}, state) do
      {:reply, id, %{"capabilities" => %{}, "serverInfo" => %{"name" => "Test LSP"}}, state}
    end

    @impl true
    def handle_notification(%Notifications.TextDocumentDidOpen{} = notification, state) do
      send(state.test_pid, {:callback, notification})

      {:noreply, state}
    end

    def handle_notification(
          %Notifications.TextDocumentDidSave{
            params: %Structures.DidSaveTextDocumentParams{textDocument: textDocument}
          } = notification,
          state
        ) do
      send(state.test_pid, {:callback, notification})

      GenLSP.notify(%Notifications.TextDocumentPublishDiagnostics{
        params: %Structures.PublishDiagnosticsParams{
          uri: textDocument.uri,
          diagnostics: [
            %{
              "range" => %{
                "start" => %{"line" => 5, "character" => 23},
                "end" => %{"line" => 6, "character" => 0}
              },
              "severity" => 1,
              "message" => "Spelling mistake"
            }
          ]
        }
      })

      {:noreply, state}
    end

    @impl true
    def handle_info(_message, state) do
      send(state.test_pid, {:info, :ack})
      {:noreply, state}
    end
  end

  setup do
    wire = start_supervised!({GenLSPTest.TestWire, self()})
    lsp = start_supervised!({GenLSPTest.ExampleServer, [test_pid: self()]})
    buffer = start_supervised!({GenLSP.Buffer, lsp})

    [lsp: lsp, buffer: buffer, wire: wire]
  end

  test "stores the user state and internal state", %{lsp: lsp} do
    assert Process.alive?(lsp)

    assert %{user_state: %{foo: :bar}, internal_state: %{mod: GenLSPTest.ExampleServer}} =
             :sys.get_state(lsp)
  end

  test "can receive and reply to a request" do
    id = System.unique_integer([:positive])

    initialize =
      Jason.encode!(%{
        "jsonrpc" => "2.0",
        "method" => "initialize",
        "params" => %{},
        "id" => id
      })

    GenLSPTest.TestWire.client_write(initialize)

    packet =
      "{\"id\":#{id},\"jsonrpc\":\"2.0\",\"result\":{\"capabilities\":{},\"serverInfo\":{\"name\":\"Test LSP\"}}}"

    assert_receive {:wire, ^packet}, 500
  end

  test "can receive a notification" do
    params = %{
      "textDocument" => %{
        "uri" => "file://somefile",
        "languageId" => "elixir",
        "version" => 1
      }
    }

    did_open =
      Jason.encode!(%{
        "jsonrpc" => "2.0",
        "method" => "textDocument/didOpen",
        "params" => params
      })

    GenLSPTest.TestWire.client_write(did_open)

    assert_receive {:callback,
                    %Notifications.TextDocumentDidOpen{
                      params: %Structures.DidOpenTextDocumentParams{
                        textDocument: %Structures.TextDocumentItem{
                          uri: "file://somefile",
                          languageId: "elixir",
                          version: 1
                        }
                      }
                    }},
                   500
  end

  test "server can send a notification" do
    params = %{
      "textDocument" => %{
        "uri" => "file://somefile",
        "languageId" => "elixir",
        "version" => 1
      },
      "text" => "some code"
    }

    did_open =
      Jason.encode!(%{
        "jsonrpc" => "2.0",
        "method" => "textDocument/didSave",
        "params" => params
      })

    GenLSPTest.TestWire.client_write(did_open)

    assert_receive {:callback,
                    %Notifications.TextDocumentDidSave{
                      params: %Structures.DidSaveTextDocumentParams{
                        textDocument: %Structures.TextDocumentIdentifier{
                          uri: "file://somefile"
                        },
                        text: "some code"
                      }
                    }},
                   500

    packet =
      Jason.encode!(%{
        "jsonrpc" => "2.0",
        "method" => "textDocument/publishDiagnostics",
        "params" => %{
          "uri" => params["textDocument"]["uri"],
          "diagnostics" => [
            %{
              "range" => %{
                "start" => %{"line" => 5, "character" => 23},
                "end" => %{"line" => 6, "character" => 0}
              },
              "severity" => 1,
              "message" => "Spelling mistake"
            }
          ],
          "version" => nil
        }
      })

    assert_receive {:wire, ^packet}, 500
  end

  test "can receive a normal message with handle_info/2", %{lsp: lsp} do
    send(lsp, "hi")

    assert_receive {:info, :ack}
  end
end
