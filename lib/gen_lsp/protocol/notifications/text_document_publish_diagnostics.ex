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
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/publishDiagnostics"),
      jsonrpc: str("2.0"),
      params: GenLSP.Structures.PublishDiagnosticsParams.schematic()
    })
  end
end
