# codegen: do not edit
defmodule GenLSP.Structures.DocumentHighlightClientCapabilities do
  @moduledoc """
  Client Capabilities for a {@link DocumentHighlightRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether document highlight supports dynamic registration.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()])
    })
  end
end
