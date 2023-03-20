# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceWillRenameFiles do
  @moduledoc """
  The will rename files request is sent from the client to the server before files are actually
  renamed as long as the rename is triggered from within the client.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/willRenameFiles"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.RenameFilesParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/willRenameFiles"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.RenameFilesParams.schematic()
    })
  end
end
