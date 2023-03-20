# codegen: do not edit
defmodule GenLSP.Structures.HoverClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether hover supports dynamic registration.
  * content_format: Client supports the following content formats for the content
    property. The order describes the preferred format of the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :content_format, list(GenLSP.Enumerations.MarkupKind.t())
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"contentFormat", :content_format} =>
        oneof([null(), list(GenLSP.Enumerations.MarkupKind.schematic())])
    })
  end
end
