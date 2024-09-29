# codegen: do not edit
defmodule GenLSP.Requests.CodeLensResolve do
  @moduledoc """
  A request to resolve a command for a given code lens.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "codeLens/resolve"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CodeLens.t()
  end

  @type result :: GenLSP.Structures.CodeLens.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "codeLens/resolve",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CodeLens.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      GenLSP.Structures.CodeLens.schema(),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
