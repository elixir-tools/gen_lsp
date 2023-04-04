# codegen: do not edit
defmodule GenLSP.Structures.DocumentLinkParams do
  @moduledoc """
  The parameters of a {@link DocumentLinkRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document to provide document links for.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schematic(),
      {"workDoneToken", :work_done_token} => nullable(GenLSP.TypeAlias.ProgressToken.schematic()),
      {"partialResultToken", :partial_result_token} =>
        nullable(GenLSP.TypeAlias.ProgressToken.schematic())
    })
  end
end
