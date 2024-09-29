# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceSymbolResolve do
  @moduledoc """
  A request to resolve the range inside the workspace
  symbol's location.

  @since 3.17.0

  Message Direction: clientToServer
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

  @type result :: GenLSP.Structures.WorkspaceSymbol.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspaceSymbol/resolve",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.WorkspaceSymbol.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      GenLSP.Structures.WorkspaceSymbol.schema(),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
