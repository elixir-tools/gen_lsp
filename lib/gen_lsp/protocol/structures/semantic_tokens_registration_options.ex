# codegen: do not edit
defmodule GenLSP.Structures.SemanticTokensRegistrationOptions do
  @moduledoc """
  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The id used to register the request. The id can be used to deregister
    the request again. See also Registration#id.
  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  * legend: The legend used by the server
  * range: Server supports providing semantic tokens for a specific range
    of a document.
  * full: Server supports providing semantic tokens for a full document.
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, String.t()
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
    field :legend, GenLSP.Structures.SemanticTokensLegend.t(), enforce: true
    field :range, boolean() | map()
    field :full, boolean() | map()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"id", :id} => oneof([null(), str()]),
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schematic(), null()]),
      {"legend", :legend} => GenLSP.Structures.SemanticTokensLegend.schematic(),
      {"range", :range} => oneof([null(), oneof([bool(), map(%{})])]),
      {"full", :full} =>
        oneof([
          null(),
          oneof([
            bool(),
            map(%{
              {"delta", :delta} => bool()
            })
          ])
        ])
    })
  end
end
