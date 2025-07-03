# codegen: do not edit
defmodule GenLSP.Notifications.TextDocumentDidChange do
  @moduledoc """
  The document change notification is sent from the client to the server to signal
  changes to a text document.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/didChange"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidChangeTextDocumentParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/didChange",
      jsonrpc: "2.0",
      params: GenLSP.Structures.DidChangeTextDocumentParams.schema()
    })
  end
end
