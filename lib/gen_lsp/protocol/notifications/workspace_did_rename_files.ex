# codegen: do not edit
defmodule GenLSP.Notifications.WorkspaceDidRenameFiles do
  @moduledoc """
  The did rename files notification is sent from the client to the server when
  files were renamed from within the client.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/didRenameFiles"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.RenameFilesParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/didRenameFiles"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.RenameFilesParams.schematic()
    })
  end
end
