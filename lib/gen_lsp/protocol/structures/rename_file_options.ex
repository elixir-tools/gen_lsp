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
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"overwrite", :overwrite}) => bool(),
      optional({"ignoreIfExists", :ignore_if_exists}) => bool()
    })
  end
end
