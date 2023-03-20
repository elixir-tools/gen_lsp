# codegen: do not edit
defmodule GenLSP.Enumerations.FileOperationPatternKind do
  @moduledoc """
  A pattern kind describing if a glob pattern matches a file a folder or
  both.

  @since 3.16.0
  """

  import Schematic, warn: false

  @doc """
  The pattern matches a file only.
  """
  def file, do: "file"

  @doc """
  The pattern matches a folder only.
  """
  def folder, do: "folder"

  @doc false
  def schematic() do
    oneof([
      str("file"),
      str("folder")
    ])
  end
end
