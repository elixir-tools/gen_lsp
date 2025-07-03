# codegen: do not edit
defmodule GenLSP.Structures.RenameFilesParams do
  @moduledoc """
  The parameters sent in notifications/requests for user-initiated renames of
  files.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * files: An array of all files/folders renamed in this operation. When a folder is renamed, only
    the folder will be included, and not its children.
  """
  @derive Jason.Encoder
  typedstruct do
    field :files, list(GenLSP.Structures.FileRename.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"files", :files} => list(GenLSP.Structures.FileRename.schema())
    })
  end
end
