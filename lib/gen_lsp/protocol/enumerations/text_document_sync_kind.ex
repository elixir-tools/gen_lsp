# codegen: do not edit
defmodule GenLSP.Enumerations.TextDocumentSyncKind do
  @moduledoc """
  Defines how the host (editor) should sync
  document changes to the language server.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * none: Documents should not be synced at all.
  * full: Documents are synced by always sending the full content
    of the document.
  * incremental: Documents are synced by sending the full content on open.
    After that only incremental updates to the document are
    send.
  """
  @derive Jason.Encoder
  typedstruct do
    field :none, GenLSP.BaseTypes.uinteger(), default: 0
    field :full, GenLSP.BaseTypes.uinteger(), default: 1
    field :incremental, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(0),
      int(1),
      int(2)
    ])
  end
end
