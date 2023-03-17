# codegen: do not edit
defmodule GenLSP.Requests.ClientUnregisterCapability do
  @moduledoc """
  The `client/unregisterCapability` request is sent from the server to the client to unregister a previously registered capability
  handler on the client side.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "client/unregisterCapability"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.UnregistrationParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("client/unregisterCapability"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.UnregistrationParams.schematic()
    })
  end
end
