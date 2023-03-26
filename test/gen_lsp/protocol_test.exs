defmodule GenLSP.ProtocolTest do
  use ExUnit.Case, async: true

  alias GenLSP.Notifications
  alias GenLSP.Requests
  alias GenLSP.Structures

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

      assert {:ok,
              %Notifications.TextDocumentDidSave{
                params: %Structures.DidSaveTextDocumentParams{
                  text_document: %Structures.TextDocumentIdentifier{
                    uri: "file://somefile"
                  },
                  text: "some code"
                }
              }} = GenLSP.Notifications.new(did_save)
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

      assert {:ok,
              %Notifications.WorkspaceDidChangeConfiguration{
                params: %Structures.DidChangeConfigurationParams{settings: _settings}
              }} = GenLSP.Notifications.new(did_change_configuration)
    end

    test "decodes a textDocument/hover packet" do
      hover = %{
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

      assert {:ok,
              %Requests.TextDocumentHover{
                params: %Structures.HoverParams{
                  text_document: %Structures.TextDocumentIdentifier{uri: _uri},
                  position: %Structures.Position{line: _line, character: _character}
                }
              }} = GenLSP.Requests.new(hover)
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

      assert {:ok,
              %Requests.Initialize{
                params: %Structures.InitializeParams{
                  workspace_folders: [
                    %GenLSP.Structures.WorkspaceFolder{
                      name: "/Users/mitchell/src/bifrost",
                      uri: "file:///Users/mitchell/src/bifrost"
                    }
                  ],
                }
              }} = GenLSP.Requests.new(initialize)
    end
  end
end
