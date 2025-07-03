# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSelectionRange do
  @moduledoc """
  A request to provide selection ranges in a document. The request's
  parameter is of type {@link SelectionRangeParams}, the
  response is of type {@link SelectionRange SelectionRange[]} or a Thenable
  that resolves to such.

  Message Direction: clientToServer
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

  @type result :: list(GenLSP.Structures.SelectionRange.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/selectionRange",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.SelectionRangeParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.SelectionRange.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
