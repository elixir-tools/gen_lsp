# codegen: do not edit
defmodule GenLSP.Requests.TypeHierarchySupertypes do
  @moduledoc """
  A request to resolve the supertypes for a given `TypeHierarchyItem`.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "typeHierarchy/supertypes"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.TypeHierarchySupertypesParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("typeHierarchy/supertypes"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.TypeHierarchySupertypesParams.schematic()
    })
  end
end
