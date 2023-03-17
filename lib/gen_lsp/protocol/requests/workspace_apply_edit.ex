# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceApplyEdit do
  @moduledoc """
  A request sent from the server to the client to modified certain resources.
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

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/applyEdit"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ApplyWorkspaceEditParams.schematic()
    })
  end
end
