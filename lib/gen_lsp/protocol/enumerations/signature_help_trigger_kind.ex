# codegen: do not edit
defmodule GenLSP.Enumerations.SignatureHelpTriggerKind do
  @moduledoc """
  How a signature help was triggered.

  @since 3.15.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * invoked: Signature help was invoked manually by the user or by a command.
  * trigger_character: Signature help was triggered by a trigger character.
  * content_change: Signature help was triggered by the cursor moving or by the document content changing.
  """
  @derive Jason.Encoder
  typedstruct do
    field :invoked, GenLSP.BaseTypes.uinteger(), default: 1
    field :trigger_character, GenLSP.BaseTypes.uinteger(), default: 2
    field :content_change, GenLSP.BaseTypes.uinteger(), default: 3
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
