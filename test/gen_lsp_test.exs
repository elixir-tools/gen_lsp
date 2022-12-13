defmodule GenLSPTest do
  use ExUnit.Case, async: true
  alias GenLSP.Protocol.Notifications
  alias GenLSP.Protocol.Structures

  setup do
    wire = start_supervised!({GenLSPTest.TestWire, self()})
    lsp = start_supervised!({GenLSPTest.ExampleServer, [test_pid: self()]})

    buffer =
      start_supervised!({GenLSP.Buffer, lsp: lsp, communication: {GenLSPTest.TestWire, []}})

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
              "code" => nil,
              "codeDescription" => nil,
              "data" => nil,
              "relatedInformation" => nil,
              "source" => nil,
              "tags" => nil,
              "range" => %{
                "start" => %{"line" => 5, "character" => 12},
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
