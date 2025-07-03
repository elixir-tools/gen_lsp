# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentTypeDefinition do
  @moduledoc """
  A request to resolve the type definition locations of a symbol at a given text
  document position. The request's parameter is of type [TextDocumentPositionParams]
  (#TextDocumentPositionParams) the response is of type {@link Definition} or a
  Thenable that resolves to such.

  Message Direction: clientToServer
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

  @type result ::
          GenLSP.TypeAlias.Definition.t() | list(GenLSP.TypeAlias.DefinitionLink.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/typeDefinition",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.TypeDefinitionParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        GenLSP.TypeAlias.Definition.schema(),
        list(GenLSP.TypeAlias.DefinitionLink.schema()),
        nil
      ]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
