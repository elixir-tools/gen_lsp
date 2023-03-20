# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionItemTag do
  @moduledoc """
  Completion item tags are extra annotations that tweak the rendering of a completion
  item.

  @since 3.15.0
  """

  import Schematic, warn: false

  @doc """
  Render a completion as obsolete, usually using a strike-out.
  """
  def deprecated, do: 1

  @doc false
  def schematic() do
    oneof([
      int(1)
    ])
  end
end
