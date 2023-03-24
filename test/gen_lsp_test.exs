defmodule GenLSPTest do
  use ExUnit.Case, async: true
  alias GenLSP.Notifications
  alias GenLSP.Structures

  import GenLSP.Test

  setup do
    server = server(GenLSPTest.ExampleServer)
    client = client(server)

    [server: server, client: client]
  end

  test "stores the user state and internal state", %{server: server} do
    assert Process.alive?(server.lsp)

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

    params = %{
      "monikerProvider" => nil,
      "diagnosticProvider" => nil,
      "executeCommandProvider" => nil,
      "colorProvider" => nil,
      "inlayHintProvider" => nil,
      "renameProvider" => nil,
      "documentSymbolProvider" => nil,
      "documentLinkProvider" => nil,
      "callHierarchyProvider" => nil,
      "semanticTokensProvider" => nil,
      "workspace" => nil,
      "completionProvider" => nil,
      "textDocumentSync" => nil,
      "codeActionProvider" => nil,
      "definitionProvider" => nil,
      "workspaceSymbolProvider" => nil,
      "signatureHelpProvider" => nil,
      "inlineValueProvider" => nil,
      "referencesProvider" => nil,
      "selectionRangeProvider" => nil,
      "documentFormattingProvider" => nil,
      "positionEncoding" => nil,
      "foldingRangeProvider" => nil,
      "typeDefinitionProvider" => nil,
      "documentHighlightProvider" => nil,
      "documentOnTypeFormattingProvider" => nil,
      "implementationProvider" => nil,
      "linkedEditingRangeProvider" => nil,
      "documentRangeFormattingProvider" => nil,
      "experimental" => nil,
      "notebookDocumentSync" => nil,
      "codeLensProvider" => nil,
      "hoverProvider" => nil,
      "declarationProvider" => nil,
      "typeHierarchyProvider" => nil
    }

    assert :ok ==
             request(client, %{
               "jsonrpc" => "2.0",
               "method" => "initialize",
               "params" => %{"capabilities" => %{}},
               "id" => id
             })

    assert_result ^id,
                  %{
                    "capabilities" => ^params,
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
                        },
                        500
  end

  test "can receive a normal message with handle_info/2", %{server: server} do
    send(server.lsp, "hi")

    assert_receive {:info, :ack}
  end
end
