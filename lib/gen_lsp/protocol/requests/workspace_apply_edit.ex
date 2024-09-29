# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceApplyEdit do
  @moduledoc """
  A request sent from the server to the client to modified certain resources.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/applyEdit"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ApplyWorkspaceEditParams.t()
  end

  @type result :: GenLSP.Structures.ApplyWorkspaceEditResult.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/applyEdit",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.ApplyWorkspaceEditParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      GenLSP.Structures.ApplyWorkspaceEditResult.schema(),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
