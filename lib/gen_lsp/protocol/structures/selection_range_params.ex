# codegen: do not edit
defmodule GenLSP.Structures.SelectionRangeParams do
  @moduledoc """
  A parameter literal used in selection range requests.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The text document.
  * positions: The positions inside the text document.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :positions, list(GenLSP.Structures.Position.t()), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"positions", :positions} => list(GenLSP.Structures.Position.schema()),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      optional({"partialResultToken", :partial_result_token}) =>
        GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
