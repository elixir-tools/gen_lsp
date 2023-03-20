# codegen: do not edit
defmodule GenLSP.Enumerations.WatchKind do
  @type t :: 1 | 2 | 4

  import Schematic, warn: false

  @doc """
  Interested in create events.
  """
  @spec create() :: 1
  def create, do: 1

  @doc """
  Interested in change events
  """
  @spec change() :: 2
  def change, do: 2

  @doc """
  Interested in delete events
  """
  @spec delete() :: 4
  def delete, do: 4

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(4)
    ])
  end
end
