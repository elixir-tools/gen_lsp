# codegen: do not edit
defmodule GenLSP.Structures.DidChangeWatchedFilesClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Did change watched files notification supports dynamic registration. Please note
    that the current protocol doesn't support static configuration for file changes
    from the server side.
  * relative_pattern_support: Whether the client has support for {@link  RelativePattern relative pattern}
    or not.

    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :relative_pattern_support, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"relativePatternSupport", :relative_pattern_support} => oneof([null(), bool()])
    })
  end
end
