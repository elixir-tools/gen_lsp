# codegen: do not edit
defmodule GenLSP.Enumerations.FileChangeType do
  @moduledoc """
  The file event type
  """

  import Schematic, warn: false

  @doc """
  The file got created.
  """
  def created, do: 1

  @doc """
  The file got changed.
  """
  def changed, do: 2

  @doc """
  The file got deleted.
  """
  def deleted, do: 3

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
