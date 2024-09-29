# codegen: do not edit
defmodule GenLSP.Structures.TextDocumentPositionParams do
  @moduledoc """
  A parameter literal used in requests to pass a text document and a position inside that
  document.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The text document.
  * position: The position inside the text document.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :position, GenLSP.Structures.Position.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"position", :position} => GenLSP.Structures.Position.schema()
    })
  end
end
