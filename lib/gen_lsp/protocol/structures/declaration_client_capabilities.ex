# codegen: do not edit
defmodule GenLSP.Structures.DeclarationClientCapabilities do
  @moduledoc """
  @since 3.14.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether declaration supports dynamic registration. If this is set to `true`
    the client supports the new `DeclarationRegistrationOptions` return value
    for the corresponding server capability as well.
  * link_support: The client supports additional metadata in the form of declaration links.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :link_support, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"linkSupport", :link_support} => oneof([null(), bool()])
    })
  end
end
