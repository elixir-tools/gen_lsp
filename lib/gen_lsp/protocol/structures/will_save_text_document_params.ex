# codegen: do not edit
defmodule GenLSP.Structures.WillSaveTextDocumentParams do
  @moduledoc """
  The parameters sent in a will save text document notification.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document that will be saved.
  * reason: The 'TextDocumentSaveReason'.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :reason, GenLSP.Enumerations.TextDocumentSaveReason.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"reason", :reason} => GenLSP.Enumerations.TextDocumentSaveReason.schema()
    })
  end
end
