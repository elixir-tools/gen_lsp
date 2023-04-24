# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentFormatting do
  @moduledoc """
  A request to format a whole document.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/formatting"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentFormattingParams.t()
  end

  @type result :: list(GenLSP.Structures.TextEdit.t()) | nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/formatting"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentFormattingParams.schematic()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.TextEdit.schematic()), null()]),
      GenLSP.ErrorResponse.schematic()
    ])
  end
end
