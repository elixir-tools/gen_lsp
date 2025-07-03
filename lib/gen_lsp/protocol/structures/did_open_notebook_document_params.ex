# codegen: do not edit
defmodule GenLSP.Structures.DidOpenNotebookDocumentParams do
  @moduledoc """
  The params sent in an open notebook document notification.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * notebook_document: The notebook document that got opened.
  * cell_text_documents: The text documents that represent the content
    of a notebook cell.
  """
  @derive Jason.Encoder
  typedstruct do
    field :notebook_document, GenLSP.Structures.NotebookDocument.t(), enforce: true
    field :cell_text_documents, list(GenLSP.Structures.TextDocumentItem.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"notebookDocument", :notebook_document} => GenLSP.Structures.NotebookDocument.schema(),
      {"cellTextDocuments", :cell_text_documents} =>
        list(GenLSP.Structures.TextDocumentItem.schema())
    })
  end
end
