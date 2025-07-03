# codegen: do not edit
defmodule GenLSP.Requests.WindowShowMessageRequest do
  @moduledoc """
  The show message request is sent from the server to the client to show a message
  and a set of options actions to the user.

  Message Direction: serverToClient
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "window/showMessageRequest"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ShowMessageRequestParams.t()
  end

  @type result :: GenLSP.Structures.MessageActionItem.t() | nil

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      method: "window/showMessageRequest",
      jsonrpc: "2.0",
      id: int(),
      params: GenLSP.Structures.ShowMessageRequestParams.schema()
    })
  end

  @doc false
  @spec result() :: Schematic.t()
  def result() do
    oneof([
      oneof([GenLSP.Structures.MessageActionItem.schema(), nil]),
      GenLSP.ErrorResponse.schema()
    ])
  end
end
