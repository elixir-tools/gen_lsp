# codegen: do not edit
defmodule GenLSP.Structures.ColorPresentationParams do
  @moduledoc """
  Parameters for a {@link ColorPresentationRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The text document.
  * color: The color to request presentations for.
  * range: The range where the color would be inserted. Serves as a context.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :color, GenLSP.Structures.Color.t(), enforce: true
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schematic(),
      {"color", :color} => GenLSP.Structures.Color.schematic(),
      {"range", :range} => GenLSP.Structures.Range.schematic(),
      {"workDoneToken", :work_done_token} =>
        oneof([null(), GenLSP.TypeAlias.ProgressToken.schematic()]),
      {"partialResultToken", :partial_result_token} =>
        oneof([null(), GenLSP.TypeAlias.ProgressToken.schematic()])
    })
  end
end
