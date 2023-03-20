# codegen: do not edit
defmodule GenLSP.Notifications.DollarCancelRequest do
  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "$/cancelRequest"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.CancelParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("$/cancelRequest"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.CancelParams.schematic()
    })
  end
end
