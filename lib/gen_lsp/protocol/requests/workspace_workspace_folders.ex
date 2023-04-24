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
    field :params, nil
  end

  @type result :: list(GenLSP.Structures.WorkspaceFolder.t()) | nil

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/workspaceFolders"),
      jsonrpc: str("2.0"),
      id: int(),
      params: null()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([list(GenLSP.Structures.WorkspaceFolder.schematic()), null()]),
      GenLSP.ErrorResponse.schematic()
    ])
  end
end
