# codegen: do not edit
defmodule GenLSP.Structures.DocumentOnTypeFormattingClientCapabilities do
  @moduledoc """
  Client capabilities of a {@link DocumentOnTypeFormattingRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether on type formatting supports dynamic registration.
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
