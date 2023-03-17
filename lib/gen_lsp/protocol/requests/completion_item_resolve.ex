# codegen: do not edit
defmodule GenLSP.Requests.CompletionItemResolve do
  @moduledoc """
  Request to resolve additional information for a given completion item.The request's
  parameter is of type {@link CompletionItem} the response
  is of type {@link CompletionItem} or a Thenable that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "completionItem/resolve"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.CompletionItem.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("completionItem/resolve"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CompletionItem.schematic()
    })
  end
end
