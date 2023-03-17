# codegen: do not edit
defmodule GenLSP.Requests.CodeLensResolve do
  @moduledoc """
  A request to resolve a command for a given code lens.
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

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      method: str("codeLens/resolve"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.CodeLens.schematic()
    })
  end
end
