# codegen: do not edit
defmodule GenLSP.Structures.RenameClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether rename supports dynamic registration.
  * prepare_support: Client supports testing for validity of rename operations
    before execution.

    @since 3.12.0
  * prepare_support_default_behavior: Client supports the default behavior result.

    The value indicates the default behavior used by the
    client.

    @since 3.16.0
  * honors_change_annotations: Whether the client honors the change annotations in
    text edits and resource operations returned via the
    rename request's workspace edit by for example presenting
    the workspace edit in the user interface and asking
    for confirmation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :prepare_support, boolean()
    field :prepare_support_default_behavior, GenLSP.Enumerations.PrepareSupportDefaultBehavior.t()
    field :honors_change_annotations, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => nullable(bool()),
      {"prepareSupport", :prepare_support} => nullable(bool()),
      {"prepareSupportDefaultBehavior", :prepare_support_default_behavior} =>
        nullable(GenLSP.Enumerations.PrepareSupportDefaultBehavior.schematic()),
      {"honorsChangeAnnotations", :honors_change_annotations} => nullable(bool())
    })
  end
end
