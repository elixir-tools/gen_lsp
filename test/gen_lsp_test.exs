defmodule GenLSPTest do
  use ExUnit.Case, async: true
  alias GenLSP.Notifications
  alias GenLSP.Structures

  import GenLSP.Test
  import ExUnit.CaptureLog

  setup do
    server = server(GenLSPTest.ExampleServer, test_pid: self())
    client = client(server)

    [server: server, client: client]
  end

  test "stores the user state and internal state", %{server: server} do
    assert alive?(server)

    assert %{foo: :bar, test_pid: self()} == :sys.get_state(server.assigns)
  end

  test "can receive and reply to a request, with handle_continue", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    # Response arrives first
    assert_result ^id,
                  %{
                    "capabilities" => %{
                      "callHierarchyProvider" => %{"workDoneProgress" => true},
                      "experimental" => nil
                    },
                    "serverInfo" => %{"name" => "Test LSP"}
                  },
                  500

    # Then handle_continue fires (after response is flushed to wire)
    assert_notification "window/logMessage", %{"message" => "post_init continue executed"}, 500
  end

  test "accepts a string id", %{client: client} do
    id = System.unique_integer([:positive]) |> to_string()

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

  # @tag :skip
  test "cancels a request", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    assert_result ^id, _, 500

    request_id = id + 1

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "textDocument/formatting",
               "params" => %{
                 "textDocument" => %{"uri" => "/path/to/file.ex"},
                 "options" => %{"insertSpaces" => true, "tabSize" => 2}
               },
               "id" => request_id
             })

    assert_receive {:request_pid, request_pid}

    ref = Process.monitor(request_pid)

    assert :ok ==
             notify(client, %{
               "jsonrpc" => "2.0",
               "method" => "$/cancelRequest",
               "params" => %{
                 "id" => request_id
               }
             })

    assert_receive {:DOWN, ^ref, :process, _object, _reason}
  end

  test "can send a request from the server to the client", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    assert_result ^id, %{"capabilities" => %{}, "serverInfo" => %{"name" => "Test LSP"}}, 500

    assert :ok ==
             notify(client, %{
               method: "initialized",
               jsonrpc: "2.0",
               params: %{}
             })

    assert_request(client, "client/registerCapability", 1000, fn params ->
      assert params == %{
               "registrations" => [
                 %{
                   "id" => "file-watching",
                   "method" => "workspace/didChangeWatchedFiles",
                   "registerOptions" => %{
                     "watchers" => [
                       %{
                         "globPattern" => "{lib|test}/**/*.{ex|exs|heex|eex|leex|surface}"
                       }
                     ]
                   }
                 }
               ]
             }

      nil
    end)

    assert_request(client, "window/showMessageRequest", 1000, fn params ->
      assert params == %{
               "type" => 1,
               "message" =>
                 "The NextLS runtime failed with errors on dependencies. Would you like to re-fetch them?",
               "actions" => [
                 %{"title" => "yes"},
                 %{"title" => "no"}
               ]
             }

      %{"title" => "yes"}
    end)

    assert_receive %GenLSP.Structures.MessageActionItem{title: "yes"}

    assert_notification "window/logMessage", %{"message" => "done initializing"}, 500
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

  test "sends an error log on exception", %{server: server} do
    send(server.lsp, :boom)

    assert_notification "window/logMessage", %{
      "message" => message,
      "type" => 1
    }

    assert message =~ "** (RuntimeError) boom"
  end

  test "returns an internal error when user code fails", %{client: client} do
    log =
      capture_log(fn ->
        :ok =
          request(client, %{
            "jsonrpc" => "2.0",
            "method" => "workspace/symbol",
            "params" => %{"query" => ""},
            "id" => 2
          })

        assert_notification "window/logMessage", %{
          "message" => message,
          "type" => 1
        }

        assert message =~ "(RuntimeError) boom"

        assert_error(2, %{
          "code" => -32603,
          "message" => message
        })

        assert message =~ "** (RuntimeError) boom"
      end)

    assert log =~ "[error] ** (RuntimeError) boom"
  end

  test "can receive a normal message with handle_info/2", %{server: server} do
    send(server.lsp, "hi")

    assert_receive {:info, :ack}
  end

  test "handle_continue chains in sequence", %{server: server} do
    send(server.lsp, :trigger_chain)

    assert_receive {:continue, :chain_step1}, 500
    assert_receive {:continue, :chain_step2}, 500
  end

  test "can respond with an error", %{client: client} do
    id = System.unique_integer([:positive])

    assert :ok ==
             request(client, %{
               method: "textDocument/definition",
               id: id,
               jsonrpc: "2.0",
               params: %{
                 position: %{line: 0, character: 0},
                 textDocument: %{uri: "foo"}
               }
             })

    assert_error(^id, %{
      "code" => -32601,
      "message" => "Method Not Found"
    })
  end

  test "can shutdown a client and server", %{client: client, server: server} do
    assert alive?(server)

    shutdown_client!(client)
    shutdown_server!(server)

    refute alive?(server)
  end

  test "returns an internal error and logs when the reply to a request is invalid", %{
    client: client
  } do
    id = System.unique_integer([:positive])

    expected_msg =
      ~S'''
      Invalid response for request textDocument/documentSymbol.

      Response: [nil, []]
      Errors: "expected either either a list of a %GenLSP.Structures.SymbolInformation{}, a list of a %GenLSP.Structures.DocumentSymbol{}, or null or a %GenLSP.ErrorResponse{}"
      '''

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    log =
      capture_log(fn ->
        assert :ok ==
                 request(client, %{
                   "jsonrpc" => "2.0",
                   "method" => "textDocument/documentSymbol",
                   "params" => %{"textDocument" => %{"uri" => "foo"}},
                   "id" => 2
                 })

        assert_error 2,
                     %{
                       "message" => msg,
                       "code" => -32603
                     },
                     500

        assert msg =~ expected_msg
      end)

    assert log =~ expected_msg
  end

  test "returns an invalid request when the payload is not parseable, but is still deemed a request",
       %{client: client} do
    assert :ok == request(client, %{"id" => "bingo", "random" => "stuff"})

    assert_error "bingo",
                 %{
                   "message" => "Invalid request from the client" <> _,
                   "code" => -32600
                 },
                 500
  end

  test "gracefully recovers from invalid requests and continues to accept requests",
       %{client: client} do
    assert :ok == request(client, %{"id" => "whoops", "random" => "again"})

    assert_error "whoops",
                 %{
                   "message" => "Invalid request from the client" <> _,
                   "code" => -32600
                 },
                 500

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

  test "logs when an invalid payload is received", %{client: client} do
    assert capture_log(fn ->
             assert :ok == notify(client, %{"random" => "stuff"})
             Process.sleep(100)
           end) =~ "Invalid notification from the client"
  end
end
