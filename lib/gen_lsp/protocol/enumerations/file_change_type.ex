# codegen: do not edit
defmodule GenLSP.Enumerations.FileChangeType do
  @moduledoc """
  The file event type
  """

  @type t :: 1 | 2 | 3

  import Schematic, warn: false

  @doc """
  The file got created.
  """
  @spec created() :: 1
  def created, do: 1

  @doc """
  The file got changed.
  """
  @spec changed() :: 2
  def changed, do: 2

  @doc """
  The file got deleted.
  """
  @spec deleted() :: 3
  def deleted, do: 3

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
