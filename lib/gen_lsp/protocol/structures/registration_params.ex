# codegen: do not edit
defmodule GenLSP.Structures.RegistrationParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * registrations
  """
  @derive Jason.Encoder
  typedstruct do
    field :registrations, list(GenLSP.Structures.Registration.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"registrations", :registrations} => list(GenLSP.Structures.Registration.schema())
    })
  end
end
