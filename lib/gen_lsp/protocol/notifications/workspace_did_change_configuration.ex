# codegen: do not edit
defmodule GenLSP.Notifications.WorkspaceDidChangeConfiguration do
  @moduledoc """
  The configuration change notification is sent from the client to the server
  when the client's configuration has changed. The notification contains
  the changed configuration as defined by the language client.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/didChangeConfiguration"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.DidChangeConfigurationParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/didChangeConfiguration",
      jsonrpc: "2.0",
      params: GenLSP.Structures.DidChangeConfigurationParams.schema()
    })
  end
end
