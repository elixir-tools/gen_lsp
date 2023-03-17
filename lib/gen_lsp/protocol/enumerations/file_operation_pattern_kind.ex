# codegen: do not edit
defmodule GenLSP.Enumerations.FileOperationPatternKind do
  @moduledoc """
  A pattern kind describing if a glob pattern matches a file a folder or
  both.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * file: The pattern matches a file only.
  * folder: The pattern matches a folder only.
  """
  @derive Jason.Encoder
  typedstruct do
    field :file, String.t(), default: "file"
    field :folder, String.t(), default: "folder"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("file"),
      str("folder")
    ])
  end
end
