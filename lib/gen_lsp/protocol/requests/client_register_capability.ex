# codegen: do not edit
defmodule GenLSP.Requests.ClientRegisterCapability do
  @moduledoc """
  The `client/registerCapability` request is sent from the server to the client to register a new capability
  handler on the client side.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "client/registerCapability"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.RegistrationParams.t()
  end

  @type result :: nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("client/registerCapability"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.RegistrationParams.schematic()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    null()
  end
end
