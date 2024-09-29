# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceDiagnostic do
  @moduledoc """
  The workspace diagnostic request definition.

  @since 3.17.0

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/diagnostic"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.WorkspaceDiagnosticParams.t()
  end

  @type result :: GenLSP.Structures.WorkspaceDiagnosticReport.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/diagnostic",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.WorkspaceDiagnosticParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      GenLSP.Structures.WorkspaceDiagnosticReport.schema(),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
