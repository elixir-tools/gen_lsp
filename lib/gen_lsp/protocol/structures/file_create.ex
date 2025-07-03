# codegen: do not edit
defmodule GenLSP.Structures.FileCreate do
  @moduledoc """
  Represents information on a file/folder create.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * uri: A file:// URI for the location of the file/folder being created.
  """
  @derive Jason.Encoder
  typedstruct do
    field :uri, String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"uri", :uri} => str()
    })
  end
end
