# codegen: do not edit
defmodule GenLSP.Structures.DeleteFileOptions do
  @moduledoc """
  Delete file options
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * recursive: Delete the content recursively if a folder is denoted.
  * ignore_if_not_exists: Ignore the operation if the file doesn't exist.
  """
  @derive Jason.Encoder
  typedstruct do
    field :recursive, boolean()
    field :ignore_if_not_exists, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"recursive", :recursive} => oneof([null(), bool()]),
      {"ignoreIfNotExists", :ignore_if_not_exists} => oneof([null(), bool()])
    })
  end
end