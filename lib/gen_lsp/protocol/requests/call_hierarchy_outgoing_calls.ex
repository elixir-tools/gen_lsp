# codegen: do not edit
defmodule GenLSP.Requests.CallHierarchyOutgoingCalls do
  @moduledoc """
  A request to resolve the outgoing calls for a given `CallHierarchyItem`.

  @since 3.16.0

  Message Direction: clientToServer
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

  @type result :: list(GenLSP.Structures.CallHierarchyOutgoingCall.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "callHierarchy/outgoingCalls",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CallHierarchyOutgoingCallsParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.CallHierarchyOutgoingCall.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
