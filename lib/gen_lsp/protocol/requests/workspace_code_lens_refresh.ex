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
  end

  @type result :: nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/codeLens/refresh",
      jsonrpc: "2.0",
      id: int()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      nil,
      GenLSP.ErrorResponse.schema()
    ])
  end
end
