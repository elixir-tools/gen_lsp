# codegen: do not edit
defmodule GenLSP.Notifications.WindowWorkDoneProgressCancel do
  @moduledoc """
  The `window/workDoneProgress/cancel` notification is sent from  the client to the server to cancel a progress
  initiated on the server side.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "window/workDoneProgress/cancel"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.WorkDoneProgressCancelParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("window/workDoneProgress/cancel"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.WorkDoneProgressCancelParams.schematic()
    })
  end
end
