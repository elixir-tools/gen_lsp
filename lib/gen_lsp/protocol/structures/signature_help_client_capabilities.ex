# codegen: do not edit
defmodule GenLSP.Structures.SignatureHelpClientCapabilities do
  @moduledoc """
  Client Capabilities for a {@link SignatureHelpRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether signature help supports dynamic registration.
  * signature_information: The client supports the following `SignatureInformation`
    specific properties.
  * context_support: The client supports to send additional context information for a
    `textDocument/signatureHelp` request. A client that opts into
    contextSupport will also support the `retriggerCharacters` on
    `SignatureHelpOptions`.

    @since 3.15.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :signature_information, map()
    field :context_support, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"signatureInformation", :signature_information} =>
        oneof([
          null(),
          map(%{
            {"documentationFormat", :documentation_format} =>
              list(GenLSP.Enumerations.MarkupKind.schematic()),
            {"parameterInformation", :parameter_information} =>
              map(%{
                {"labelOffsetSupport", :label_offset_support} => bool()
              }),
            {"activeParameterSupport", :active_parameter_support} => bool()
          })
        ]),
      {"contextSupport", :context_support} => oneof([null(), bool()])
    })
  end
end
