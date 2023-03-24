# codegen: do not edit
defmodule GenLSP.Requests.TextDocumentColorPresentation do
  @moduledoc """
  A request to list all presentation for a color. The request's
  parameter is of type {@link ColorPresentationParams} the
  response is of type {@link ColorInformation ColorInformation[]} or a Thenable
  that resolves to such.
  """

  import Schematic, warn: false

  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :method, String.t(), default: "textDocument/colorPresentation"
    field :jsonrpc, String.t(), default: "2.0"
    field :id, integer(), enforce: true
    field :params, GenLSP.Structures.ColorPresentationParams.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      method: str("textDocument/colorPresentation"),
      jsonrpc: str("2.0"),
      id: int(),
      params: GenLSP.Structures.ColorPresentationParams.schematic()
    })
  end
end
