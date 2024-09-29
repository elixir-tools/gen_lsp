# codegen: do not edit
defmodule GenLSP.Structures.DidSaveNotebookDocumentParams do
  @moduledoc """
  The params sent in a save notebook document notification.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * notebook_document: The notebook document that got saved.
  """
  @derive Jason.Encoder
  typedstruct do
    field :notebook_document, GenLSP.Structures.NotebookDocumentIdentifier.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"notebookDocument", :notebook_document} =>
        GenLSP.Structures.NotebookDocumentIdentifier.schema()
    })
  end
end
