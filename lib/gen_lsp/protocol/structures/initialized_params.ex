# codegen: do not edit
defmodule GenLSP.Structures.InitializedParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  """
  @derive Jason.Encoder
  typedstruct do
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{})
  end
end
