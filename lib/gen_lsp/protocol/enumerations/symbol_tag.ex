# codegen: do not edit
defmodule GenLSP.Enumerations.SymbolTag do
  @moduledoc """
  Symbol tags are extra annotations that tweak the rendering of a symbol.

  @since 3.16
  """

  import Schematic, warn: false

  @doc """
  Render a symbol as obsolete, usually using a strike-out.
  """
  def deprecated, do: 1

  @doc false
  def schematic() do
    oneof([
      int(1)
    ])
  end
end
