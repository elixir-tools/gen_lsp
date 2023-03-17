# codegen: do not edit
defmodule GenLSP.Notifications.DollarSetTrace do
  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "$/setTrace"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.SetTraceParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("$/setTrace"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.SetTraceParams.schematic()
    })
  end
end
