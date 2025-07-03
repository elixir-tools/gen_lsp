# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceFoldersInitializeParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * workspace_folders: The workspace folders configured in the client when the server starts.

    This property is only available if the client supports workspace folders.
    It can be `null` if the client supports workspace folders but none are
    configured.

    @since 3.6.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :workspace_folders, list(GenLSP.Structures.WorkspaceFolder.t()) | nil
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"workspaceFolders", :workspace_folders}) =>
        oneof([list(GenLSP.Structures.WorkspaceFolder.schema()), nil])
    })
  end
end
