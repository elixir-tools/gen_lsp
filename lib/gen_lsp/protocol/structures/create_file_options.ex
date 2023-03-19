# codegen: do not edit
defmodule GenLSP.Structures.CreateFileOptions do
  @moduledoc """
  Options to create a file.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * overwrite: Overwrite existing file. Overwrite wins over `ignoreIfExists`
  * ignore_if_exists: Ignore if exists.
  """
  @derive Jason.Encoder
  typedstruct do
    field :overwrite, boolean()
    field :ignore_if_exists, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"overwrite", :overwrite} => oneof([null(), bool()]),
      {"ignoreIfExists", :ignore_if_exists} => oneof([null(), bool()])
    })
  end
end