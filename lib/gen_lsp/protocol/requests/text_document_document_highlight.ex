# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentHighlight do
  @moduledoc """
  Request to resolve a {@link DocumentHighlight} for a given
  text document position. The request's parameter is of type [TextDocumentPosition]
  (#TextDocumentPosition) the request response is of type [DocumentHighlight[]]
  (#DocumentHighlight) or a Thenable that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/documentHighlight"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentHighlightParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/documentHighlight"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentHighlightParams.schematic()
    })
  end
end
