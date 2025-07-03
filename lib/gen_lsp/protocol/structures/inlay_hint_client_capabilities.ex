# codegen: do not edit
defmodule GenLSP.Structures.InlayHintClientCapabilities do
  @moduledoc """
  Inlay hint client capabilities.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether inlay hints support dynamic registration.
  * resolve_support: Indicates which properties a client can resolve lazily on an inlay
    hint.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :resolve_support, map()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"dynamicRegistration", :dynamic_registration}) => bool(),
      optional({"resolveSupport", :resolve_support}) =>
        map(%{
          {"properties", :properties} => list(str())
        })
    })
  end
end
