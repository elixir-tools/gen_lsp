# codegen: do not edit
defmodule GenLSP.Enumerations.DocumentHighlightKind do
  @moduledoc """
  A document highlight kind.
  """

  import Schematic, warn: false

  @doc """
  A textual occurrence.
  """
  def text, do: 1

  @doc """
  Read-access of a symbol, like reading a variable.
  """
  def read, do: 2

  @doc """
  Write-access of a symbol, like writing to a variable.
  """
  def write, do: 3

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
