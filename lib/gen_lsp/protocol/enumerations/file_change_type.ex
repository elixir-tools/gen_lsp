# codegen: do not edit
defmodule GenLSP.Enumerations.FileChangeType do
  @moduledoc """
  The file event type
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * created: The file got created.
  * changed: The file got changed.
  * deleted: The file got deleted.
  """
  @derive Jason.Encoder
  typedstruct do
    field :created, GenLSP.BaseTypes.uinteger(), default: 1
    field :changed, GenLSP.BaseTypes.uinteger(), default: 2
    field :deleted, GenLSP.BaseTypes.uinteger(), default: 3
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
