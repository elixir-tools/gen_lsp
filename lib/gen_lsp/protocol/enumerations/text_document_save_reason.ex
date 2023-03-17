# codegen: do not edit
defmodule GenLSP.Enumerations.TextDocumentSaveReason do
  @moduledoc """
  Represents reasons why a text document is saved.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * manual: Manually triggered, e.g. by the user pressing save, by starting debugging,
    or by an API call.
  * after_delay: Automatic after a delay.
  * focus_out: When the editor lost focus.
  """
  @derive Jason.Encoder
  typedstruct do
    field :manual, GenLSP.BaseTypes.uinteger(), default: 1
    field :after_delay, GenLSP.BaseTypes.uinteger(), default: 2
    field :focus_out, GenLSP.BaseTypes.uinteger(), default: 3
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
