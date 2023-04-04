# codegen: do not edit
defmodule GenLSP.Structures.RenameFileOptions do
  @moduledoc """
  Rename file options
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * overwrite: Overwrite target if existing. Overwrite wins over `ignoreIfExists`
  * ignore_if_exists: Ignores if target exists.
  """
  @derive Jason.Encoder
  typedstruct do
    field :overwrite, boolean()
    field :ignore_if_exists, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"overwrite", :overwrite} => nullable(bool()),
      {"ignoreIfExists", :ignore_if_exists} => nullable(bool())
    })
  end
end
