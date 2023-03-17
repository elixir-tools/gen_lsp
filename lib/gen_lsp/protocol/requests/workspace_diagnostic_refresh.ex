# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceDiagnosticRefresh do
  @moduledoc """
  The diagnostic refresh request definition.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/diagnostic/refresh"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, nil
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/diagnostic/refresh"),
      jsonrpc: str("2.0"),
      id: int(),
      params: null()
    })
  end
end
