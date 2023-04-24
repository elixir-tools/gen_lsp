defmodule GenLSPTest do
  use ExUnit.Case, async: true
  alias GenLSP.Notifications
  alias GenLSP.Structures

  import GenLSP.Test

  setup do
    server = server(GenLSPTest.ExampleServer, test_pid: self())
    client = client(server)

    [server: server, client: client]
  end

  test "stores the user state and internal state", %{server: server} do
    assert alive?(server)

    assert %GenLSP.LSP{
             assigns: %{foo: :bar, test_pid: self()},
             buffer: server.buffer,
             pid: server.lsp,
             mod: GenLSPTest.ExampleServer
           } ==
             :sys.get_state(server.lsp)
  end

  test "can receive and reply to a request", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    assert_result ^id,
                  %{
                    "capabilities" => %{
                      "callHierarchyProvider" => %{"workDoneProgress" => true},
                      "experimental" => nil
                    },
                    "serverInfo" => %{"name" => "Test LSP"}
                  },
                  500
  end

  test "the server can receive a notification", %{client: client} do
    assert :ok ==
             notify(client, %{
               "jsonrpc" => "2.0",
               "method" => "textDocument/didOpen",
               "params" => %{
                 "textDocument" => %{
                   "uri" => "file://somefile",
                   "languageId" => "elixir",
                   "version" => 1,
                   "text" => "hello world!"
                 }
               }
             })

    assert_receive {:callback,
                    %Notifications.TextDocumentDidOpen{
                      params: %Structures.DidOpenTextDocumentParams{
                        text_document: %Structures.TextDocumentItem{
                          uri: "file://somefile",
                          language_id: "elixir",
                          version: 1
                        }
                      }
                    }},
                   500
  end

  test "server can send a notification", %{client: client} do
    expected_uri = "file://somefile"

    assert :ok ==
             notify(client, %{
               "jsonrpc" => "2.0",
               "method" => "textDocument/didSave",
               "params" => %{
                 "textDocument" => %{
                   "uri" => expected_uri,
                   "languageId" => "elixir",
                   "version" => 1
                 },
                 "text" => "some code"
               }
             })

    assert_notification "textDocument/publishDiagnostics",
                        %{
                          "uri" => ^expected_uri,
                          "diagnostics" => [
                            %{
                              "range" => %{
                                "start" => %{"line" => 5, "character" => 12},
                                "end" => %{"line" => 6, "character" => 0}
                              },
                              "severity" => 1,
                              "message" => "Spelling mistake"
                            }
                          ]
                        },
                        500
  end

  test "can receive a normal message with handle_info/2", %{server: server} do
    send(server.lsp, "hi")

    assert_receive {:info, :ack}
  end

  test "can respond with an error", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               method: "textDocument/documentSymbol",
               id: id,
               jsonrpc: "2.0",
               params: %{
                 textDocument: %{
                   uri: "file://file/doesnt/matter.ex"
                 }
               }
             })

    assert_error(^id, %{
      "code" => -32601,
      "message" => "Method Not Found"
    })
  end
end
