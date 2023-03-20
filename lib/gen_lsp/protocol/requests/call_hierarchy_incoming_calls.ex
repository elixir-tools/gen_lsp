# codegen: do not edit
defmodule GenLSP.Requests.CallHierarchyIncomingCalls do
  @moduledoc """
  A request to resolve the incoming calls for a given `CallHierarchyItem`.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "callHierarchy/incomingCalls"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CallHierarchyIncomingCallsParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("callHierarchy/incomingCalls"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CallHierarchyIncomingCallsParams.schematic()
    })
  end
end
