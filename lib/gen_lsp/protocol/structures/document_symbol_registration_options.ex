# codegen: do not edit
defmodule GenLSP.Structures.DocumentSymbolRegistrationOptions do
  @moduledoc """
  Registration options for a {@link DocumentSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  * label: A human-readable string that is shown when multiple outlines trees
    are shown for the same document.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
    field :label, String.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schema(), nil]),
      optional({"label", :label}) => str()
    })
  end
end
