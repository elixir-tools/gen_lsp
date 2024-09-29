# codegen: do not edit
defmodule GenLSP.Requests.TypeHierarchySubtypes do
  @moduledoc """
  A request to resolve the subtypes for a given `TypeHierarchyItem`.

  @since 3.17.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "typeHierarchy/subtypes"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.TypeHierarchySubtypesParams.t()
  end

  @type result :: list(GenLSP.Structures.TypeHierarchyItem.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "typeHierarchy/subtypes",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.TypeHierarchySubtypesParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.TypeHierarchyItem.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
