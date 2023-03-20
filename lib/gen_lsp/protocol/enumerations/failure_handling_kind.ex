# codegen: do not edit
defmodule GenLSP.Enumerations.FailureHandlingKind do
  import Schematic, warn: false

  @doc """
  Applying the workspace change is simply aborted if one of the changes provided
  fails. All operations executed before the failing operation stay executed.
  """
  def abort, do: "abort"

  @doc """
  All operations are executed transactional. That means they either all
  succeed or no changes at all are applied to the workspace.
  """
  def transactional, do: "transactional"

  @doc """
  If the workspace edit contains only textual file changes they are executed transactional.
  If resource changes (create, rename or delete file) are part of the change the failure
  handling strategy is abort.
  """
  def text_only_transactional, do: "textOnlyTransactional"

  @doc """
  The client tries to undo the operations already executed. But there is no
  guarantee that this is succeeding.
  """
  def undo, do: "undo"

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
