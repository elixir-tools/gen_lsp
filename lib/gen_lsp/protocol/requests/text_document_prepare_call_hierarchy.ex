# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentPrepareCallHierarchy do
  @moduledoc """
  A request to result a `CallHierarchyItem` in a document at a given position.
  Can be used as an input to an incoming or outgoing call hierarchy.

  @since 3.16.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/prepareCallHierarchy"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CallHierarchyPrepareParams.t()
  end

  @type result :: list(GenLSP.Structures.CallHierarchyItem.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/prepareCallHierarchy",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CallHierarchyPrepareParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.CallHierarchyItem.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
