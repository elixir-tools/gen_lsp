# codegen: do not edit
defmodule GenLSP.Structures.DocumentRangeFormattingClientCapabilities do
  @moduledoc """
  Client capabilities of a {@link DocumentRangeFormattingRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether range formatting supports dynamic registration.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => nullable(bool())
    })
  end
end
