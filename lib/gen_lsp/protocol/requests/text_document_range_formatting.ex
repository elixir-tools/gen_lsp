# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentRangeFormatting do
  @moduledoc """
  A request to format a range in a document.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/rangeFormatting"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentRangeFormattingParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/rangeFormatting"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentRangeFormattingParams.schematic()
    })
  end
end
