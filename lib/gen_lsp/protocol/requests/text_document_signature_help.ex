# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentSignatureHelp do
  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/signatureHelp"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.SignatureHelpParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/signatureHelp"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.SignatureHelpParams.schematic()
    })
  end
end
