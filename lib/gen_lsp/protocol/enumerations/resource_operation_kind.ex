# codegen: do not edit
defmodule GenLSP.Enumerations.ResourceOperationKind do
  import Schematic, warn: false

  @doc """
  Supports creating new files and folders.
  """
  def create, do: "create"

  @doc """
  Supports renaming existing files and folders.
  """
  def rename, do: "rename"

  @doc """
  Supports deleting existing files and folders.
  """
  def delete, do: "delete"

  @doc false
  def schematic() do
    oneof([
      str("create"),
      str("rename"),
      str("delete")
    ])
  end
end
