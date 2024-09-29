# codegen: do not edit
defmodule GenLSP.Structures.InlayHintParams do
  @moduledoc """
  A parameter literal used in inlay hint requests.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The text document.
  * range: The document range for which inlay hints should be computed.
  * work_done_token: An optional token that a server can use to report work done progress.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"range", :range} => GenLSP.Structures.Range.schema(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
