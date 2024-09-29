# codegen: do not edit
defmodule GenLSP.Structures.DidOpenTextDocumentParams do
  @moduledoc """
  The parameters sent in an open text document notification
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document that was opened.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentItem.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentItem.schema()
    })
  end
end
