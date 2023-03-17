# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentColor do
  @moduledoc """
  A request to list all color symbols found in a given text document. The request's
  parameter is of type {@link DocumentColorParams} the
  response is of type {@link ColorInformation ColorInformation[]} or a Thenable
  that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/documentColor"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentColorParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/documentColor"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentColorParams.schematic()
    })
  end
end
