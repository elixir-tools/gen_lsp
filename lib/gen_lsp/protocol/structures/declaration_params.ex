# codegen: do not edit
defmodule GenLSP.Structures.DeclarationParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  * text_document: The text document.
  * position: The position inside the text document.
  """
  @derive Jason.Encoder
  typedstruct do
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :position, GenLSP.Structures.Position.t(), enforce: true
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"workDoneToken", :work_done_token} => nullable(GenLSP.TypeAlias.ProgressToken.schematic()),
      {"partialResultToken", :partial_result_token} =>
        nullable(GenLSP.TypeAlias.ProgressToken.schematic()),
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schematic(),
      {"position", :position} => GenLSP.Structures.Position.schematic()
    })
  end
end
