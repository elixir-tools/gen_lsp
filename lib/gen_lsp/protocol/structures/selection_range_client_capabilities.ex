# codegen: do not edit
defmodule GenLSP.Structures.SelectionRangeClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether implementation supports dynamic registration for selection range providers. If this is set to `true`
    the client supports the new `SelectionRangeRegistrationOptions` return value for the corresponding server
    capability as well.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()])
    })
  end
end