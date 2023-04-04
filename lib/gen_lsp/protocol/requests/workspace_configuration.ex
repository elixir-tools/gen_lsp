# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceConfiguration do
  @moduledoc """
  The 'workspace/configuration' request is sent from the server to the client to fetch a certain
  configuration setting.

  This pull model replaces the old push model were the client signaled configuration change via an
  event. If the server still needs to react to configuration changes (since the server caches the
  result of `workspace/configuration` requests) the server should register for an empty configuration
  change event and empty the cache if such an event is received.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/configuration"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ConfigurationParams.t()
  end

  @type result :: list(GenLSP.TypeAlias.LSPAny.t())

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("workspace/configuration"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ConfigurationParams.schematic()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    list(GenLSP.TypeAlias.LSPAny.schematic())
  end
end
