# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionItemTag do
  @moduledoc """
  Completion item tags are extra annotations that tweak the rendering of a completion
  item.

  @since 3.15.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * deprecated: Render a completion as obsolete, usually using a strike-out.
  """
  @derive Jason.Encoder
  typedstruct do
    field :deprecated, GenLSP.BaseTypes.uinteger(), default: 1
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1)
    ])
  end
end
