# codegen: do not edit
defmodule GenLSP.Structures.SignatureHelpParams do
  @moduledoc """
  Parameters for a {@link SignatureHelpRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * context: The signature help context. This is only available if the client specifies
    to send this using the client capability `textDocument.signatureHelp.contextSupport === true`

    @since 3.15.0
  * work_done_token: An optional token that a server can use to report work done progress.
  * text_document: The text document.
  * position: The position inside the text document.
  """
  @derive Jason.Encoder
  typedstruct do
    field :context, GenLSP.Structures.SignatureHelpContext.t()
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
    field :position, GenLSP.Structures.Position.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"context", :context}) => GenLSP.Structures.SignatureHelpContext.schema(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema(),
      {"position", :position} => GenLSP.Structures.Position.schema()
    })
  end
end
