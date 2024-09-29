# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentMoniker do
  @moduledoc """
  A request to get the moniker of a symbol at a given text document position.
  The request parameter is of type {@link TextDocumentPositionParams}.
  The response is of type {@link Moniker Moniker[]} or `null`.

  Message Direction: clientToServer
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

  @type result :: list(GenLSP.Structures.Moniker.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/moniker",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.MonikerParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.Moniker.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
