# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentTypeDefinition do
  @moduledoc """
  A request to resolve the type definition locations of a symbol at a given text
  document position. The request's parameter is of type [TextDocumentPositionParams]
  (#TextDocumentPositionParams) the response is of type {@link Definition} or a
  Thenable that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/typeDefinition"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.TypeDefinitionParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/typeDefinition"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.TypeDefinitionParams.schematic()
    })
  end
end
