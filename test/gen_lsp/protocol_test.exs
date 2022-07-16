defmodule GenLsp.ProtocolTest do
  use ExUnit.Case, async: true

  alias GenLSP.Protocol.Notifications
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
  end
end
