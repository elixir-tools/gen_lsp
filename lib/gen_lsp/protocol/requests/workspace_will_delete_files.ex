# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceWillDeleteFiles do
  @moduledoc """
  The did delete files notification is sent from the client to the server when
  files were deleted from within the client.

  @since 3.16.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/willDeleteFiles"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.DeleteFilesParams.t()
  end

  @type result :: GenLSP.Structures.WorkspaceEdit.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/willDeleteFiles",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.DeleteFilesParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.WorkspaceEdit.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
