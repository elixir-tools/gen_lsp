# codegen: do not edit
defmodule GenLSP.Enumerations.CodeActionTriggerKind do
  @moduledoc """
  The reason why code actions were requested.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * invoked: Code actions were explicitly requested by the user or by an extension.
  * automatic: Code actions were requested automatically.

    This typically happens when current selection in a file changes, but can
    also be triggered when file content changes.
  """
  @derive Jason.Encoder
  typedstruct do
    field :invoked, GenLSP.BaseTypes.uinteger(), default: 1
    field :automatic, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
