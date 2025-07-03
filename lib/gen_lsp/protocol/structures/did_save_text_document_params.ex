# codegen: do not edit
defmodule GenLSP.Structures.DidSaveTextDocumentParams do
  @moduledoc """
  The parameters sent in a save text document notification
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document that was saved.
  * text: Optional the content when saved. Depends on the includeText value
    when the save notification was requested.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :text, String.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      optional({"text", :text}) => str()
    })
  end
end
