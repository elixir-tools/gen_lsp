# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentReferences do
  @moduledoc """
  A request to resolve project-wide references for the symbol denoted
  by the given text document position. The request's parameter is of
  type {@link ReferenceParams} the response is of type
  {@link Location Location[]} or a Thenable that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/references"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ReferenceParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/references"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ReferenceParams.schematic()
    })
  end
end
