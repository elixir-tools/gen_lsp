# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentSymbol do
  @moduledoc """
  A request to list all symbols found in a given text document. The request's
  parameter is of type {@link TextDocumentIdentifier} the
  response is of type {@link SymbolInformation SymbolInformation[]} or a Thenable
  that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/documentSymbol"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentSymbolParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/documentSymbol"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentSymbolParams.schematic()
    })
  end
end
