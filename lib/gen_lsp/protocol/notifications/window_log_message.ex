# codegen: do not edit
defmodule GenLSP.Notifications.WindowLogMessage do
  @moduledoc """
  The log message notification is sent from the server to the client to ask
  the client to log a particular message.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "window/logMessage"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.LogMessageParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("window/logMessage"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.LogMessageParams.schematic()
    })
  end
end
