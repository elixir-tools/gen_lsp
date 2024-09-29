# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentCodeAction do
  @moduledoc """
  A request to provide commands for the given text document and range.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/codeAction"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CodeActionParams.t()
  end

  @type result :: list(GenLSP.Structures.Command.t() | GenLSP.Structures.CodeAction.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/codeAction",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CodeActionParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        list(oneof([GenLSP.Structures.Command.schema(), GenLSP.Structures.CodeAction.schema()])),
        nil
      ]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
