# codegen: do not edit
defmodule GenLSP.Enumerations.SignatureHelpTriggerKind do
  @moduledoc """
  How a signature help was triggered.

  @since 3.15.0
  """

  import Schematic, warn: false

  @doc """
  Signature help was invoked manually by the user or by a command.
  """
  def invoked, do: 1

  @doc """
  Signature help was triggered by a trigger character.
  """
  def trigger_character, do: 2

  @doc """
  Signature help was triggered by the cursor moving or by the document content changing.
  """
  def content_change, do: 3

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
