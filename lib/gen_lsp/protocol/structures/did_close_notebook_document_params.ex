# codegen: do not edit
defmodule GenLSP.Structures.DidCloseNotebookDocumentParams do
  @moduledoc """
  The params sent in a close notebook document notification.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * notebook_document: The notebook document that got closed.
  * cell_text_documents: The text documents that represent the content
    of a notebook cell that got closed.
  """
  @derive Jason.Encoder
  typedstruct do
    field :notebook_document, GenLSP.Structures.NotebookDocumentIdentifier.t(), enforce: true
    field :cell_text_documents, list(GenLSP.Structures.TextDocumentIdentifier.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"notebookDocument", :notebook_document} =>
        GenLSP.Structures.NotebookDocumentIdentifier.schema(),
      {"cellTextDocuments", :cell_text_documents} =>
        list(GenLSP.Structures.TextDocumentIdentifier.schema())
    })
  end
end
