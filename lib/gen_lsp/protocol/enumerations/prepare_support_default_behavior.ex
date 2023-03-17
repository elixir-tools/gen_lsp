# codegen: do not edit
defmodule GenLSP.Enumerations.PrepareSupportDefaultBehavior do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * identifier: The client's default behavior is to select the identifier
    according the to language's syntax rule.
  """
  @derive Jason.Encoder
  typedstruct do
    field :identifier, GenLSP.BaseTypes.uinteger(), default: 1
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1)
    ])
  end
end
