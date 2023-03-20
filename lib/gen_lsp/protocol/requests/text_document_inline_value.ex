# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentInlineValue do
  @moduledoc """
  A request to provide inline values in a document. The request's parameter is of
  type {@link InlineValueParams}, the response is of type
  {@link InlineValue InlineValue[]} or a Thenable that resolves to such.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/inlineValue"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.InlineValueParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/inlineValue"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.InlineValueParams.schematic()
    })
  end
end
