# codegen: do not edit
defmodule GenLSP.Requests.Shutdown do
  @moduledoc """
  A shutdown request is sent from the client to the server.
  It is sent once when the client decides to shutdown the
  server. The only notification that is sent after a shutdown request
  is the exit event.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "shutdown"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, nil
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("shutdown"),
      jsonrpc: str("2.0"),
      id: int(),
      params: null()
    })
  end
end
