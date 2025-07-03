# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentReferences do
  @moduledoc """
  A request to resolve project-wide references for the symbol denoted
  by the given text document position. The request's parameter is of
  type {@link ReferenceParams} the response is of type
  {@link Location Location[]} or a Thenable that resolves to such.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/references"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ReferenceParams.t()
  end

  @type result :: list(GenLSP.Structures.Location.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/references",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.ReferenceParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.Location.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
