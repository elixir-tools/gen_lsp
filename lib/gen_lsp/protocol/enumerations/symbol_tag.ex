# codegen: do not edit
defmodule GenLSP.Enumerations.SymbolTag do
  @moduledoc """
  Symbol tags are extra annotations that tweak the rendering of a symbol.

  @since 3.16
  """

  @type t :: 1

  import Schematic, warn: false

  @doc """
  Render a symbol as obsolete, usually using a strike-out.
  """
  @spec deprecated() :: 1
  def deprecated, do: 1

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      1
    ])
  end
end
