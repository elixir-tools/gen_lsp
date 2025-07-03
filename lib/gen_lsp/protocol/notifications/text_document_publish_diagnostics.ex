# codegen: do not edit
defmodule GenLSP.Notifications.TextDocumentPublishDiagnostics do
  @moduledoc """
  Diagnostics notification are sent from the server to the client to signal
  results of validation runs.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/publishDiagnostics"
    field :jsonrpc, String.t(), default: "2.0"
    field :params, GenLSP.Structures.PublishDiagnosticsParams.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "textDocument/publishDiagnostics",
      jsonrpc: "2.0",
      params: GenLSP.Structures.PublishDiagnosticsParams.schema()
    })
  end
end
