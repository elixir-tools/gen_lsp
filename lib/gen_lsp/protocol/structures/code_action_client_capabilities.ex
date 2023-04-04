# codegen: do not edit
defmodule GenLSP.Structures.CodeActionClientCapabilities do
  @moduledoc """
  The Client Capabilities of a {@link CodeActionRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether code action supports dynamic registration.
  * code_action_literal_support: The client support code action literals of type `CodeAction` as a valid
    response of the `textDocument/codeAction` request. If the property is not
    set the request can only return `Command` literals.

    @since 3.8.0
  * is_preferred_support: Whether code action supports the `isPreferred` property.

    @since 3.15.0
  * disabled_support: Whether code action supports the `disabled` property.

    @since 3.16.0
  * data_support: Whether code action supports the `data` property which is
    preserved between a `textDocument/codeAction` and a
    `codeAction/resolve` request.

    @since 3.16.0
  * resolve_support: Whether the client supports resolving additional code action
    properties via a separate `codeAction/resolve` request.

    @since 3.16.0
  * honors_change_annotations: Whether the client honors the change annotations in
    text edits and resource operations returned via the
    `CodeAction#edit` property by for example presenting
    the workspace edit in the user interface and asking
    for confirmation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :code_action_literal_support, map()
    field :is_preferred_support, boolean()
    field :disabled_support, boolean()
    field :data_support, boolean()
    field :resolve_support, map()
    field :honors_change_annotations, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => nullable(bool()),
      {"codeActionLiteralSupport", :code_action_literal_support} =>
        nullable(
          map(%{
            {"codeActionKind", :code_action_kind} =>
              map(%{
                {"valueSet", :value_set} => list(GenLSP.Enumerations.CodeActionKind.schematic())
              })
          })
        ),
      {"isPreferredSupport", :is_preferred_support} => nullable(bool()),
      {"disabledSupport", :disabled_support} => nullable(bool()),
      {"dataSupport", :data_support} => nullable(bool()),
      {"resolveSupport", :resolve_support} =>
        nullable(
          map(%{
            {"properties", :properties} => list(str())
          })
        ),
      {"honorsChangeAnnotations", :honors_change_annotations} => nullable(bool())
    })
  end
end
