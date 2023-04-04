# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceCodeLensRefresh do
  @moduledoc """
  A request to refresh all code actions

  @since 3.16.0

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/codeLens/refresh"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, nil
  end

  @type result :: nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/codeLens/refresh"),
      jsonrpc: str("2.0"),
      id: int(),
      params: null()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    null()
  end
end
