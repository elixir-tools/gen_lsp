# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentPrepareCallHierarchy do
  @moduledoc """
  A request to result a `CallHierarchyItem` in a document at a given position.
  Can be used as an input to an incoming or outgoing call hierarchy.

  @since 3.16.0
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

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/prepareCallHierarchy"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CallHierarchyPrepareParams.schematic()
    })
  end
end
