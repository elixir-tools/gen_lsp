# codegen: do not edit
defmodule GenLSP.Enumerations.TextDocumentSyncKind do
  @moduledoc """
  Defines how the host (editor) should sync
  document changes to the language server.
  """

  import Schematic, warn: false

  @doc """
  Documents should not be synced at all.
  """
  def none, do: 0

  @doc """
  Documents are synced by always sending the full content
  of the document.
  """
  def full, do: 1

  @doc """
  Documents are synced by sending the full content on open.
  After that only incremental updates to the document are
  send.
  """
  def incremental, do: 2

  @doc false
  def schematic() do
    oneof([
      int(0),
      int(1),
      int(2)
    ])
  end
end
