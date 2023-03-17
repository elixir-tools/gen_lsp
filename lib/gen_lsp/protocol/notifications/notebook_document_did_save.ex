# codegen: do not edit
defmodule GenLSP.Notifications.NotebookDocumentDidSave do
  @moduledoc """
  A notification sent when a notebook document is saved.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "notebookDocument/didSave"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidSaveNotebookDocumentParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("notebookDocument/didSave"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.DidSaveNotebookDocumentParams.schematic()
    })
  end
end
