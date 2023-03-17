# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSelectionRange do
  @moduledoc """
  A request to provide selection ranges in a document. The request's
  parameter is of type {@link SelectionRangeParams}, the
  response is of type {@link SelectionRange SelectionRange[]} or a Thenable
  that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/selectionRange"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.SelectionRangeParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/selectionRange"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.SelectionRangeParams.schematic()
    })
  end
end
