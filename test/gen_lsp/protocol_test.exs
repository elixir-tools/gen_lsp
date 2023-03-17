defmodule GenLSP.ProtocolTest do
  use ExUnit.Case, async: true

  alias GenLSP.Protocol.Notifications
  alias GenLSP.Protocol.Requests
  alias GenLSP.Protocol.Structures

  describe "new/1" do
    test "decodes a textDocument/didSave packet" do
      did_save = %{
        "jsonrpc" => "2.0",
        "method" => "textDocument/didSave",
        "params" => %{
          "textDocument" => %{
            "uri" => "file://somefile"
          },
          "text" => "some code"
        }
      }

      assert %Notifications.TextDocumentDidSave{
               params: %Structures.DidSaveTextDocumentParams{
                 textDocument: %Structures.TextDocumentIdentifier{
                   uri: "file://somefile"
                 },
                 text: "some code"
               }
             } = GenLSP.Protocol.new(did_save)
    end

    test "decodes a workspace/didChangeConfiguration packet" do
      did_change_configuration = %{
        "jsonrpc" => "2.0",
        "method" => "workspace/didChangeConfiguration",
        "params" => %{
          "settings" => %{
            "elixirLS" => %{
              "dialyzerEnabled" => false,
              "enableTestLenses" => false,
              "fetchDeps" => false,
              "suggestSpecs" => false
            }
          }
        }
      }

      assert %Notifications.WorkspaceDidChangeConfiguration{
               params: %Structures.DidChangeConfigurationParams{settings: _settings}
             } = GenLSP.Protocol.new(did_change_configuration)
    end

    test "decodes a textDocument/hover packet" do
      did_change_configuration = %{
        "id" => 2,
        "jsonrpc" => "2.0",
        "method" => "textDocument/hover",
        "params" => %{
          "position" => %{"character" => 17, "line" => 19},
          "textDocument" => %{
            "uri" => "file:///Users/mitchell/src/bifrost/lib/bifrost/application.ex"
          }
        }
      }

      assert %Requests.TextDocumentHover{
               params: %Structures.HoverParams{
                 textDocument: %Structures.TextDocumentIdentifier{uri: _uri},
                 position: %Structures.Position{line: _line, character: _character}
               }
             } = GenLSP.Protocol.new(did_change_configuration)
    end

    test "decodes initialize" do
      initialize = %{
        "id" => 1,
        "jsonrpc" => "2.0",
        "method" => "initialize",
        "params" => %{
          "capabilities" => %{
            "callHierarchy" => %{"dynamicRegistration" => false},
            "textDocument" => %{
              "codeAction" => %{
                "codeActionLiteralSupport" => %{
                  "codeActionKind" => %{
                    "valueSet" => [
                      "",
                      "Empty",
                      "QuickFix",
                      "Refactor",
                      "RefactorExtract",
                      "RefactorInline",
                      "RefactorRewrite",
                      "Source",
                      "SourceOrganizeImports",
                      "quickfix",
                      "refactor",
                      "refactor.extract",
                      "refactor.inline",
                      "refactor.rewrite",
                      "source",
                      "source.organizeImports"
                    ]
                  }
                },
                "dataSupport" => true,
                "dynamicRegistration" => false,
                "isPreferredSupport" => true,
                "resolveSupport" => %{"properties" => ["edit"]}
              },
              "completion" => %{
                "completionItem" => %{
                  "commitCharactersSupport" => false,
                  "deprecatedSupport" => false,
                  "documentationFormat" => ["markdown", "plaintext"],
                  "preselectSupport" => false,
                  "snippetSupport" => true
                },
                "completionItemKind" => %{
                  "valueSet" => [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15,
                    16,
                    17,
                    18,
                    19,
                    20,
                    21,
                    22,
                    23,
                    24,
                    25
                  ]
                },
                "contextSupport" => false,
                "dynamicRegistration" => false
              },
              "declaration" => %{"linkSupport" => true},
              "definition" => %{"linkSupport" => true},
              "documentHighlight" => %{"dynamicRegistration" => false},
              "documentSymbol" => %{
                "dynamicRegistration" => false,
                "hierarchicalDocumentSymbolSupport" => true,
                "symbolKind" => %{
                  "valueSet" => [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15,
                    16,
                    17,
                    18,
                    19,
                    20,
                    21,
                    22,
                    23,
                    24,
                    25,
                    26
                  ]
                }
              },
              "hover" => %{
                "contentFormat" => ["markdown", "plaintext"],
                "dynamicRegistration" => false
              },
              "implementation" => %{"linkSupport" => true},
              "publishDiagnostics" => %{
                "relatedInformation" => true,
                "tagSupport" => %{"valueSet" => [1, 2]}
              },
              "references" => %{"dynamicRegistration" => false},
              "rename" => %{"dynamicRegistration" => false, "prepareSupport" => true},
              "signatureHelp" => %{
                "dynamicRegistration" => false,
                "signatureInformation" => %{
                  "activeParameterSupport" => true,
                  "documentationFormat" => ["markdown", "plaintext"],
                  "parameterInformation" => %{"labelOffsetSupport" => true}
                }
              },
              "synchronization" => %{
                "didSave" => true,
                "dynamicRegistration" => false,
                "willSave" => false,
                "willSaveWaitUntil" => false
              },
              "typeDefinition" => %{"linkSupport" => true}
            },
            "window" => %{
              "showDocument" => %{"support" => false},
              "showMessage" => %{"messageActionItem" => %{"additionalPropertiesSupport" => false}},
              "workDoneProgress" => true
            },
            "workspace" => %{
              "applyEdit" => true,
              "configuration" => true,
              "symbol" => %{
                "dynamicRegistration" => false,
                "hierarchicalWorkspaceSymbolSupport" => true,
                "symbolKind" => %{
                  "valueSet" => [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15,
                    16,
                    17,
                    18,
                    19,
                    20,
                    21,
                    22,
                    23,
                    24,
                    25,
                    26
                  ]
                }
              },
              "workspaceEdit" => %{"resourceOperations" => ["rename", "create", "delete"]},
              "workspaceFolders" => true
            }
          },
          "clientInfo" => %{"name" => "Neovim", "version" => "0.8.0"},
          "initializationOptions" => %{},
          "processId" => 72252,
          "rootPath" => "/Users/mitchell/src/bifrost",
          "rootUri" => "file:///Users/mitchell/src/bifrost",
          "trace" => "off",
          "workspaceFolders" => [
            %{
              "name" => "/Users/mitchell/src/bifrost",
              "uri" => "file:///Users/mitchell/src/bifrost"
            }
          ]
        }
      }

      assert %Requests.Initialize{params: %Structures.InitializeParams{}} =
               GenLSP.Protocol.new(initialize)
    end
  end
end
