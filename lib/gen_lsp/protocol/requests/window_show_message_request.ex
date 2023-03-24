# codegen: do not edit
defmodule GenLSP.Requests.WindowShowMessageRequest do
  @moduledoc """
  The show message request is sent from the server to the client to show a message
  and a set of options actions to the user.
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

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("window/showMessageRequest"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ShowMessageRequestParams.schematic()
    })
  end
end
