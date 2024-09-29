# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSemanticTokensRange do
  @moduledoc """
  @since 3.16.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/semanticTokens/range"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.SemanticTokensRangeParams.t()
  end

  @type result :: GenLSP.Structures.SemanticTokens.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/semanticTokens/range",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.SemanticTokensRangeParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.SemanticTokens.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
