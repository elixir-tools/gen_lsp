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
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"dynamicRegistration", :dynamic_registration}) => bool(),
      optional({"contentFormat", :content_format}) =>
        list(GenLSP.Enumerations.MarkupKind.schema())
    })
  end
end
