# codegen: do not edit
defmodule GenLSP.Structures.DocumentLinkClientCapabilities do
  @moduledoc """
  The client capabilities of a {@link DocumentLinkRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether document link supports dynamic registration.
  * tooltip_support: Whether the client supports the `tooltip` property on `DocumentLink`.

    @since 3.15.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :tooltip_support, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => nullable(bool()),
      {"tooltipSupport", :tooltip_support} => nullable(bool())
    })
  end
end
