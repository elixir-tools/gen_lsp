# codegen: do not edit
defmodule GenLSP.Requests.WorkspaceSymbol do
  @moduledoc """
  A request to list project-wide symbols matching the query string given
  by the {@link WorkspaceSymbolParams}. The response is
  of type {@link SymbolInformation SymbolInformation[]} or a Thenable that
  resolves to such.

  @since 3.17.0 - support for WorkspaceSymbol in the returned data. Clients
   need to advertise support for WorkspaceSymbols via the client capability
   `workspace.symbol.resolveSupport`.


  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "workspace/symbol"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.WorkspaceSymbolParams.t()
  end

  @type result ::
          list(GenLSP.Structures.SymbolInformation.t())
          | list(GenLSP.Structures.WorkspaceSymbol.t())
          | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "workspace/symbol",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.WorkspaceSymbolParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([
        list(GenLSP.Structures.SymbolInformation.schema()),
        list(GenLSP.Structures.WorkspaceSymbol.schema()),
        nil
      ]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
