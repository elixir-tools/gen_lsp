# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSemanticTokensFullDelta do
  @moduledoc """
  @since 3.16.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/semanticTokens/full/delta"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.SemanticTokensDeltaParams.t()
  end

  @type result ::
          GenLSP.Structures.SemanticTokens.t() | GenLSP.Structures.SemanticTokensDelta.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/semanticTokens/full/delta",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.SemanticTokensDeltaParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        GenLSP.Structures.SemanticTokens.schema(),
        GenLSP.Structures.SemanticTokensDelta.schema(),
        nil
      ]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
