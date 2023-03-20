# codegen: do not edit
defmodule GenLSP.Requests.CallHierarchyOutgoingCalls do
  @moduledoc """
  A request to resolve the outgoing calls for a given `CallHierarchyItem`.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "callHierarchy/outgoingCalls"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CallHierarchyOutgoingCallsParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("callHierarchy/outgoingCalls"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CallHierarchyOutgoingCallsParams.schematic()
    })
  end
end
