# codegen: do not edit
defmodule GenLSP.Enumerations.WatchKind do
  import Schematic, warn: false

  @doc """
  Interested in create events.
  """
  def create, do: 1

  @doc """
  Interested in change events
  """
  def change, do: 2

  @doc """
  Interested in delete events
  """
  def delete, do: 4

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(4)
    ])
  end
end
