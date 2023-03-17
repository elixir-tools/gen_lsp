# codegen: do not edit
defmodule GenLSP.Enumerations.InlayHintKind do
  @moduledoc """
  Inlay hint kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * type: An inlay hint that for a type annotation.
  * parameter: An inlay hint that is for a parameter.
  """
  @derive Jason.Encoder
  typedstruct do
    field :type, GenLSP.BaseTypes.uinteger(), default: 1
    field :parameter, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
