# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentInlayHint do
  @moduledoc """
  A request to provide inlay hints in a document. The request's parameter is of
  type {@link InlayHintsParams}, the response is of type
  {@link InlayHint InlayHint[]} or a Thenable that resolves to such.

  @since 3.17.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/inlayHint"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.InlayHintParams.t()
  end

  @type result :: list(GenLSP.Structures.InlayHint.t()) | nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/inlayHint"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.InlayHintParams.schematic()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([list(GenLSP.Structures.InlayHint.schematic()), null()])
  end
end
