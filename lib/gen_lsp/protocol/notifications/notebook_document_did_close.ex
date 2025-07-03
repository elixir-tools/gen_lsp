# codegen: do not edit
defmodule GenLSP.Notifications.NotebookDocumentDidClose do
  @moduledoc """
  A notification sent when a notebook closes.

  @since 3.17.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "notebookDocument/didClose"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidCloseNotebookDocumentParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "notebookDocument/didClose",
      jsonrpc: "2.0",
      params: GenLSP.Structures.DidCloseNotebookDocumentParams.schema()
    })
  end
end
