# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentPrepareTypeHierarchy do
  @moduledoc """
  A request to result a `TypeHierarchyItem` in a document at a given position.
  Can be used as an input to a subtypes or supertypes type hierarchy.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/prepareTypeHierarchy"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.TypeHierarchyPrepareParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/prepareTypeHierarchy"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.TypeHierarchyPrepareParams.schematic()
    })
  end
end
