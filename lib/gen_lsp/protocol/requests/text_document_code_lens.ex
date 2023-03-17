# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentCodeLens do
  @moduledoc """
  A request to provide code lens for the given text document.
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

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/codeLens"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CodeLensParams.schematic()
    })
  end
end
