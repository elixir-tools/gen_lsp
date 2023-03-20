# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentCodeAction do
  @moduledoc """
  A request to provide commands for the given text document and range.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/codeAction"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CodeActionParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/codeAction"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CodeActionParams.schematic()
    })
  end
end
