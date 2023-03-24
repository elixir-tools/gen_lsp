# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentLinkedEditingRange do
  @moduledoc """
  A request to provide ranges that can be edited together.

  @since 3.16.0
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

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/linkedEditingRange"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.LinkedEditingRangeParams.schematic()
    })
  end
end
