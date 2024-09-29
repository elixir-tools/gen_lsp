# codegen: do not edit
defmodule GenLSP.Structures.DocumentFormattingParams do
  @moduledoc """
  The parameters of a {@link DocumentFormattingRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document to format.
  * options: The format options.
  * work_done_token: An optional token that a server can use to report work done progress.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :options, GenLSP.Structures.FormattingOptions.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"options", :options} => GenLSP.Structures.FormattingOptions.schema(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
