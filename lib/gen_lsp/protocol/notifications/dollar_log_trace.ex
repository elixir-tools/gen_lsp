# codegen: do not edit
defmodule GenLSP.Notifications.DollarLogTrace do
  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "$/logTrace"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.LogTraceParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "$/logTrace",
      jsonrpc: "2.0",
      params: GenLSP.Structures.LogTraceParams.schema()
    })
  end
end
