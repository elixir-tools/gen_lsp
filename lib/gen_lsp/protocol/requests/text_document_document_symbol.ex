# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentSymbol do
  @moduledoc """
  A request to list all symbols found in a given text document. The request's
  parameter is of type {@link TextDocumentIdentifier} the
  response is of type {@link SymbolInformation SymbolInformation[]} or a Thenable
  that resolves to such.

  Message Direction: clientToServer
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

  @type result ::
          list(GenLSP.Structures.SymbolInformation.t())
          | list(GenLSP.Structures.DocumentSymbol.t())
          | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/documentSymbol",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.DocumentSymbolParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        list(GenLSP.Structures.SymbolInformation.schema()),
        list(GenLSP.Structures.DocumentSymbol.schema()),
        nil
      ]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
