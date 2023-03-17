# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentMoniker do
  @moduledoc """
  A request to get the moniker of a symbol at a given text document position.
  The request parameter is of type {@link TextDocumentPositionParams}.
  The response is of type {@link Moniker Moniker[]} or `null`.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/moniker"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.MonikerParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/moniker"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.MonikerParams.schematic()
    })
  end
end
