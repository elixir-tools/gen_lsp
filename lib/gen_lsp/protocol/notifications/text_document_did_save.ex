# codegen: do not edit
defmodule GenLSP.Notifications.TextDocumentDidSave do
  @moduledoc """
  The document save notification is sent from the client to the server when
  the document got saved in the client.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/didSave"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidSaveTextDocumentParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/didSave"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.DidSaveTextDocumentParams.schematic()
    })
  end
end
