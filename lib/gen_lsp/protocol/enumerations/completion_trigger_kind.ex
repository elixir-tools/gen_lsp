# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionTriggerKind do
  @moduledoc """
  How a completion was triggered
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * invoked: Completion was triggered by typing an identifier (24x7 code
    complete), manual invocation (e.g Ctrl+Space) or via API.
  * trigger_character: Completion was triggered by a trigger character specified by
    the `triggerCharacters` properties of the `CompletionRegistrationOptions`.
  * trigger_for_incomplete_completions: Completion was re-triggered as current completion list is incomplete
  """
  @derive Jason.Encoder
  typedstruct do
    field :invoked, GenLSP.BaseTypes.uinteger(), default: 1
    field :trigger_character, GenLSP.BaseTypes.uinteger(), default: 2
    field :trigger_for_incomplete_completions, GenLSP.BaseTypes.uinteger(), default: 3
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
