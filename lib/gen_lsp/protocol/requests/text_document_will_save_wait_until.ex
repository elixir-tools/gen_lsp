# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentWillSaveWaitUntil do
  @moduledoc """
  A document will save request is sent from the client to the server before
  the document is actually saved. The request can return an array of TextEdits
  which will be applied to the text document before it is saved. Please note that
  clients might drop results if computing the text edits took too long or if a
  server constantly fails on this request. This is done to keep the save fast and
  reliable.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/willSaveWaitUntil"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.WillSaveTextDocumentParams.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/willSaveWaitUntil"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.WillSaveTextDocumentParams.schematic()
    })
  end
end
