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

  @type result :: GenLSP.Structures.SignatureHelp.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/signatureHelp",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.SignatureHelpParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.SignatureHelp.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
