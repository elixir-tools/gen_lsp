# codegen: do not edit
defmodule GenLSP.Structures.TextDocumentChangeRegistrationOptions do
  @moduledoc """
  Describe options to be used when registered for text document change events.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * sync_kind: How documents are synced to the server.
  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  """
  @derive Jason.Encoder
  typedstruct do
    field :sync_kind, GenLSP.Enumerations.TextDocumentSyncKind.t(), enforce: true
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"syncKind", :sync_kind} => GenLSP.Enumerations.TextDocumentSyncKind.schema(),
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schema(), nil])
    })
  end
end
