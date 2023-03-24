# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceExecuteCommand do
  @moduledoc """
  A request send from the client to the server to execute a command. The request might return
  a workspace edit which the client will apply to the workspace.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/executeCommand"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ExecuteCommandParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/executeCommand"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ExecuteCommandParams.schematic()
    })
  end
end
