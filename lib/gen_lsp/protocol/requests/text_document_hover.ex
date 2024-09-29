# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentHover do
  @moduledoc """
  Request to request hover information at a given text document position. The request's
  parameter is of type {@link TextDocumentPosition} the response is of
  type {@link Hover} or a Thenable that resolves to such.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/hover"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.HoverParams.t()
  end

  @type result :: GenLSP.Structures.Hover.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/hover",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.HoverParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.Hover.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
