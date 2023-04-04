# codegen: do not edit
defmodule GenLSP.Structures.SemanticTokensDeltaParams do
  @moduledoc """
  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The text document.
  * previous_result_id: The result id of a previous response. The result Id can either point to a full response
    or a delta response depending on what was received last.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :previous_result_id, String.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schematic(),
      {"previousResultId", :previous_result_id} => str(),
      {"workDoneToken", :work_done_token} => nullable(GenLSP.TypeAlias.ProgressToken.schematic()),
      {"partialResultToken", :partial_result_token} =>
        nullable(GenLSP.TypeAlias.ProgressToken.schematic())
    })
  end
end
