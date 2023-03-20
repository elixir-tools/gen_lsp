# codegen: do not edit
defmodule GenLSP.Enumerations.InlayHintKind do
  @moduledoc """
  Inlay hint kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  @doc """
  An inlay hint that for a type annotation.
  """
  def type, do: 1

  @doc """
  An inlay hint that is for a parameter.
  """
  def parameter, do: 2

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
