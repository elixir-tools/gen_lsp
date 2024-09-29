# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceExecuteCommand do
  @moduledoc """
  A request send from the client to the server to execute a command. The request might return
  a workspace edit which the client will apply to the workspace.

  Message Direction: clientToServer
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

  @type result :: GenLSP.TypeAlias.LSPAny.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/executeCommand",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.ExecuteCommandParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.TypeAlias.LSPAny.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
