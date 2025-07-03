# codegen: do not edit
defmodule GenLSP.Notifications.Initialized do
  @moduledoc """
  The initialized notification is sent from the client to the
  server after the client is fully initialized and the server
  is allowed to send requests from the server to the client.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "initialized"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.InitializedParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "initialized",
      jsonrpc: "2.0",
      params: GenLSP.Structures.InitializedParams.schema()
    })
  end
end
