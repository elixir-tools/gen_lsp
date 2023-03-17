# codegen: do not edit
defmodule GenLSP.Enumerations.TokenFormat do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * relative
  """
  @derive Jason.Encoder
  typedstruct do
    field :relative, String.t(), default: "relative"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("relative")
    ])
  end
end
