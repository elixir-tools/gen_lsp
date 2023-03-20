# codegen: do not edit
defmodule GenLSP.Notifications.WorkspaceDidChangeWorkspaceFolders do
  @moduledoc """
  The `workspace/didChangeWorkspaceFolders` notification is sent from the client to the server when the workspace
  folder configuration changes.
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
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/didChangeWorkspaceFolders"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.DidChangeWorkspaceFoldersParams.schematic()
    })
  end
end
