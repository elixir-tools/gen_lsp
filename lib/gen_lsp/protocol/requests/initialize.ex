# codegen: do not edit
defmodule GenLSP.Requests.Initialize do
  @moduledoc """
  The initialize request is sent from the client to the server.
  It is sent once as the request after starting up the server.
  The requests parameter is of type {@link InitializeParams}
  the response if of type {@link InitializeResult} of a Thenable that
  resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "initialize"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.InitializeParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("initialize"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.InitializeParams.schematic()
    })
  end
end
