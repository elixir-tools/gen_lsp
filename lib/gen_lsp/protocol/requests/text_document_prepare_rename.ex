# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentPrepareRename do
  @moduledoc """
  A request to test and perform the setup necessary for a rename.

  @since 3.16 - support for default behavior

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/prepareRename"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.PrepareRenameParams.t()
  end

  @type result :: GenLSP.TypeAlias.PrepareRenameResult.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/prepareRename",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.PrepareRenameParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.TypeAlias.PrepareRenameResult.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
