# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentOnTypeFormatting do
  @moduledoc """
  A request to format a document on type.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/onTypeFormatting"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentOnTypeFormattingParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/onTypeFormatting"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentOnTypeFormattingParams.schematic()
    })
  end
end
