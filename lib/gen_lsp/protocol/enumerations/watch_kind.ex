# codegen: do not edit
defmodule GenLSP.Enumerations.WatchKind do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * create: Interested in create events.
  * change: Interested in change events
  * delete: Interested in delete events
  """
  @derive Jason.Encoder
  typedstruct do
    field :create, GenLSP.BaseTypes.uinteger(), default: 1
    field :change, GenLSP.BaseTypes.uinteger(), default: 2
    field :delete, GenLSP.BaseTypes.uinteger(), default: 4
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(4)
    ])
  end
end
