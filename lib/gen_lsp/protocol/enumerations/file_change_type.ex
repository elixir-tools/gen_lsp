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
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      1,
      2,
      3
    ])
  end
end
