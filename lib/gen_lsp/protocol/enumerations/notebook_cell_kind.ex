# codegen: do not edit
defmodule GenLSP.Enumerations.NotebookCellKind do
  @moduledoc """
  A notebook cell kind.

  @since 3.17.0
  """

  import Schematic, warn: false

  @doc """
  A markup-cell is formatted source that is used for display.
  """
  def markup, do: 1

  @doc """
  A code-cell is source code.
  """
  def code, do: 2

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
