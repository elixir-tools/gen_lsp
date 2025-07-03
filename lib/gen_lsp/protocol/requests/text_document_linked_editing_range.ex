# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentLinkedEditingRange do
  @moduledoc """
  A request to provide ranges that can be edited together.

  @since 3.16.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/linkedEditingRange"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.LinkedEditingRangeParams.t()
  end

  @type result :: GenLSP.Structures.LinkedEditingRanges.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/linkedEditingRange",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.LinkedEditingRangeParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.LinkedEditingRanges.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
