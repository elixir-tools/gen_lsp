# codegen: do not edit
defmodule GenLSP.Enumerations.ResourceOperationKind do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * create: Supports creating new files and folders.
  * rename: Supports renaming existing files and folders.
  * delete: Supports deleting existing files and folders.
  """
  @derive Jason.Encoder
  typedstruct do
    field :create, String.t(), default: "create"
    field :rename, String.t(), default: "rename"
    field :delete, String.t(), default: "delete"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("create"),
      str("rename"),
      str("delete")
    ])
  end
end
