# codegen: do not edit
defmodule GenLSP.Enumerations.FailureHandlingKind do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * abort: Applying the workspace change is simply aborted if one of the changes provided
    fails. All operations executed before the failing operation stay executed.
  * transactional: All operations are executed transactional. That means they either all
    succeed or no changes at all are applied to the workspace.
  * text_only_transactional: If the workspace edit contains only textual file changes they are executed transactional.
    If resource changes (create, rename or delete file) are part of the change the failure
    handling strategy is abort.
  * undo: The client tries to undo the operations already executed. But there is no
    guarantee that this is succeeding.
  """
  @derive Jason.Encoder
  typedstruct do
    field :abort, String.t(), default: "abort"
    field :transactional, String.t(), default: "transactional"
    field :text_only_transactional, String.t(), default: "textOnlyTransactional"
    field :undo, String.t(), default: "undo"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("abort"),
      str("transactional"),
      str("textOnlyTransactional"),
      str("undo")
    ])
  end
end
