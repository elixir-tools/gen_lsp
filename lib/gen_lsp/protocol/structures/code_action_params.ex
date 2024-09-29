# codegen: do not edit
defmodule GenLSP.Structures.CodeActionParams do
  @moduledoc """
  The parameters of a {@link CodeActionRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document in which the command was invoked.
  * range: The range for which the command was invoked.
  * context: Context carrying additional information.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :context, GenLSP.Structures.CodeActionContext.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"range", :range} => GenLSP.Structures.Range.schema(),
      {"context", :context} => GenLSP.Structures.CodeActionContext.schema(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      optional({"partialResultToken", :partial_result_token}) =>
        GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
