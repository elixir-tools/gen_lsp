# codegen: do not edit
defmodule GenLSP.Structures.ExecuteCommandClientCapabilities do
  @moduledoc """
  The client capabilities of a {@link ExecuteCommandRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Execute command supports dynamic registration.
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
