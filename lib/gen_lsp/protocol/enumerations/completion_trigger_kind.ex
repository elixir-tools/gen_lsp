# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionTriggerKind do
  @moduledoc """
  How a completion was triggered
  """

  import Schematic, warn: false

  @doc """
  Completion was triggered by typing an identifier (24x7 code
  complete), manual invocation (e.g Ctrl+Space) or via API.
  """
  def invoked, do: 1

  @doc """
  Completion was triggered by a trigger character specified by
  the `triggerCharacters` properties of the `CompletionRegistrationOptions`.
  """
  def trigger_character, do: 2

  @doc """
  Completion was re-triggered as current completion list is incomplete
  """
  def trigger_for_incomplete_completions, do: 3

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
