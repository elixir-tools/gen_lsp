# codegen: do not edit
defmodule GenLSP.Requests.WindowWorkDoneProgressCreate do
  @moduledoc """
  The `window/workDoneProgress/create` request is sent from the server to the client to initiate progress
  reporting from the server.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "window/workDoneProgress/create"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.WorkDoneProgressCreateParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("window/workDoneProgress/create"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.WorkDoneProgressCreateParams.schematic()
    })
  end
end
