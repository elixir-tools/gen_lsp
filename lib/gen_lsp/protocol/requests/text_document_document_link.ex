# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentLink do
  @moduledoc """
  A request to provide document links

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/documentLink"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DocumentLinkParams.t()
  end

  @type result :: list(GenLSP.Structures.DocumentLink.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/documentLink",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.DocumentLinkParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.DocumentLink.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
