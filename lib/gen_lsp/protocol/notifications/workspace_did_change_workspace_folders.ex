# codegen: do not edit
defmodule GenLSP.Notifications.WorkspaceDidChangeWorkspaceFolders do
  @moduledoc """
  The `workspace/didChangeWorkspaceFolders` notification is sent from the client to the server when the workspace
  folder configuration changes.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/didChangeWorkspaceFolders"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidChangeWorkspaceFoldersParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/didChangeWorkspaceFolders",
      jsonrpc: "2.0",
      params: GenLSP.Structures.DidChangeWorkspaceFoldersParams.schema()
    })
  end
end
