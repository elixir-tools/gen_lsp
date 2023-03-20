# codegen: do not edit
defmodule GenLSP.Enumerations.CodeActionTriggerKind do
  @moduledoc """
  The reason why code actions were requested.

  @since 3.17.0
  """

  import Schematic, warn: false

  @doc """
  Code actions were explicitly requested by the user or by an extension.
  """
  def invoked, do: 1

  @doc """
  Code actions were requested automatically.

  This typically happens when current selection in a file changes, but can
  also be triggered when file content changes.
  """
  def automatic, do: 2

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
