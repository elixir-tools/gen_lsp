# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceSymbolResolve do
  @moduledoc """
  A request to resolve the range inside the workspace
  symbol's location.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspaceSymbol/resolve"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.WorkspaceSymbol.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspaceSymbol/resolve"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.WorkspaceSymbol.schematic()
    })
  end
end
