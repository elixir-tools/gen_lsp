# codegen: do not edit
defmodule GenLSP.Requests.Shutdown do
  @moduledoc """
  A shutdown request is sent from the client to the server.
  It is sent once when the client decides to shutdown the
  server. The only notification that is sent after a shutdown request
  is the exit event.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "shutdown"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
  end

  @type result :: nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "shutdown",
      jsonrpc: "2.0",
      id: int()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      nil,
      GenLSP.ErrorResponse.schema()
    ])
  end
end
