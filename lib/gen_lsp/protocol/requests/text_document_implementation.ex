# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentImplementation do
  @moduledoc """
  A request to resolve the implementation locations of a symbol at a given text
  document position. The request's parameter is of type [TextDocumentPositionParams]
  (#TextDocumentPositionParams) the response is of type {@link Definition} or a
  Thenable that resolves to such.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/implementation"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ImplementationParams.t()
  end

  @type result ::
          GenLSP.TypeAlias.Definition.t() | list(GenLSP.TypeAlias.DefinitionLink.t()) | nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/implementation"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ImplementationParams.schematic()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        GenLSP.TypeAlias.Definition.schematic(),
        list(GenLSP.TypeAlias.DefinitionLink.schematic()),
        null()
      ]),
      GenLSP.ErrorResponse.schematic()
    ])
  end
end
