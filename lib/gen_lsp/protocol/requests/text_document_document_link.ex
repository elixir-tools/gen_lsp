# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentDocumentLink do
  @moduledoc """
  A request to provide document links
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

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/documentLink"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.DocumentLinkParams.schematic()
    })
  end
end
