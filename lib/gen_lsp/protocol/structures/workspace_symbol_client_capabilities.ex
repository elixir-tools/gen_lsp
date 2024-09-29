# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceSymbolClientCapabilities do
  @moduledoc """
  Client capabilities for a {@link WorkspaceSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Symbol request supports dynamic registration.
  * symbol_kind: Specific capabilities for the `SymbolKind` in the `workspace/symbol` request.
  * tag_support: The client supports tags on `SymbolInformation`.
    Clients supporting tags have to handle unknown tags gracefully.

    @since 3.16.0
  * resolve_support: The client support partial workspace symbols. The client will send the
    request `workspaceSymbol/resolve` to the server to resolve additional
    properties.

    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :symbol_kind, map()
    field :tag_support, map()
    field :resolve_support, map()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"dynamicRegistration", :dynamic_registration}) => bool(),
      optional({"symbolKind", :symbol_kind}) =>
        map(%{
          optional({"valueSet", :value_set}) => list(GenLSP.Enumerations.SymbolKind.schema())
        }),
      optional({"tagSupport", :tag_support}) =>
        map(%{
          {"valueSet", :value_set} => list(GenLSP.Enumerations.SymbolTag.schema())
        }),
      optional({"resolveSupport", :resolve_support}) =>
        map(%{
          {"properties", :properties} => list(str())
        })
    })
  end
end
