# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSemanticTokensRange do
  @moduledoc """
  @since 3.16.0
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

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/semanticTokens/range"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.SemanticTokensRangeParams.schematic()
    })
  end
end
