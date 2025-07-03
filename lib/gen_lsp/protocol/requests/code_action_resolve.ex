# codegen: do not edit
defmodule GenLSP.Requests.CodeActionResolve do
  @moduledoc """
  Request to resolve additional information for a given code action.The request's
  parameter is of type {@link CodeAction} the response
  is of type {@link CodeAction} or a Thenable that resolves to such.

  Message Direction: clientToServer
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "codeAction/resolve"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CodeAction.t()
  end

  @type result :: GenLSP.Structures.CodeAction.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "codeAction/resolve",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.CodeAction.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      GenLSP.Structures.CodeAction.schema(),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
