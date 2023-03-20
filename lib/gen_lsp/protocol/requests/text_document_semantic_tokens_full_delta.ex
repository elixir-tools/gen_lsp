# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSemanticTokensFullDelta do
  @moduledoc """
  @since 3.16.0
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

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/semanticTokens/full/delta"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.SemanticTokensDeltaParams.schematic()
    })
  end
end
