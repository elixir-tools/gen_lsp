# codegen: do not edit
defmodule GenLSP.Structures.CodeLensRegistrationOptions do
  @moduledoc """
  Registration options for a {@link CodeLensRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  * resolve_provider: Code lens has a resolve provider as well.
  """
  @derive Jason.Encoder
  typedstruct do
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
    field :resolve_provider, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schema(), nil]),
      optional({"resolveProvider", :resolve_provider}) => bool()
    })
  end
end
