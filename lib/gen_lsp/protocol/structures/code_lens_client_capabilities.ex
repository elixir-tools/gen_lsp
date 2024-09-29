# codegen: do not edit
defmodule GenLSP.Structures.CodeLensClientCapabilities do
  @moduledoc """
  The client capabilities  of a {@link CodeLensRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether code lens supports dynamic registration.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"dynamicRegistration", :dynamic_registration}) => bool()
    })
  end
end
