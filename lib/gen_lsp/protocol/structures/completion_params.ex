# codegen: do not edit
defmodule GenLSP.Structures.CompletionParams do
  @moduledoc """
  Completion parameters
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * context: The completion context. This is only available it the client specifies
    to send this using the client capability `textDocument.completion.contextSupport === true`
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  * text_document: The text document.
  * position: The position inside the text document.
  """
  @derive Jason.Encoder
  typedstruct do
    field :context, GenLSP.Structures.CompletionContext.t()
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :position, GenLSP.Structures.Position.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"context", :context}) => GenLSP.Structures.CompletionContext.schema(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      optional({"partialResultToken", :partial_result_token}) =>
        GenLSP.TypeAlias.ProgressToken.schema(),
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"position", :position} => GenLSP.Structures.Position.schema()
    })
  end
end
