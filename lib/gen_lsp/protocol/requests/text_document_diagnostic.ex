# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDiagnostic do
  @moduledoc """
  The document diagnostic request definition.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/diagnostic"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentDiagnosticParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/diagnostic"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentDiagnosticParams.schematic()
    })
  end
end
