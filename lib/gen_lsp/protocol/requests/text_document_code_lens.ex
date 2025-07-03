# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentCodeLens do
  @moduledoc """
  A request to provide code lens for the given text document.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/codeLens"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CodeLensParams.t()
  end

  @type result :: list(GenLSP.Structures.CodeLens.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/codeLens",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CodeLensParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.CodeLens.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
