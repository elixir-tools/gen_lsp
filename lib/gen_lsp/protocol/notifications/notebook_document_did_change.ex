# codegen: do not edit
defmodule GenLSP.Notifications.NotebookDocumentDidChange do
  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "notebookDocument/didChange"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidChangeNotebookDocumentParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("notebookDocument/didChange"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.DidChangeNotebookDocumentParams.schematic()
    })
  end
end
