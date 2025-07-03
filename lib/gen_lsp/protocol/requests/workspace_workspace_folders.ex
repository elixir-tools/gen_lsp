# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceWorkspaceFolders do
  @moduledoc """
  The `workspace/workspaceFolders` is sent from the server to the client to fetch the open workspace folders.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/workspaceFolders"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
  end

  @type result :: list(GenLSP.Structures.WorkspaceFolder.t()) | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/workspaceFolders",
      jsonrpc: "2.0",
      id: int()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.WorkspaceFolder.schema()), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
