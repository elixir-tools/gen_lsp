# codegen: do not edit
defmodule GenLSP.Structures.DocumentSymbolClientCapabilities do
  @moduledoc """
  Client Capabilities for a {@link DocumentSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether document symbol supports dynamic registration.
  * symbol_kind: Specific capabilities for the `SymbolKind` in the
    `textDocument/documentSymbol` request.
  * hierarchical_document_symbol_support: The client supports hierarchical document symbols.
  * tag_support: The client supports tags on `SymbolInformation`. Tags are supported on
    `DocumentSymbol` if `hierarchicalDocumentSymbolSupport` is set to true.
    Clients supporting tags have to handle unknown tags gracefully.

    @since 3.16.0
  * label_support: The client supports an additional label presented in the UI when
    registering a document symbol provider.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :symbol_kind, map()
    field :hierarchical_document_symbol_support, boolean()
    field :tag_support, map()
    field :label_support, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"symbolKind", :symbol_kind} =>
        oneof([
          null(),
          map(%{
            {"valueSet", :value_set} =>
              oneof([null(), list(GenLSP.Enumerations.SymbolKind.schematic())])
          })
        ]),
      {"hierarchicalDocumentSymbolSupport", :hierarchical_document_symbol_support} =>
        oneof([null(), bool()]),
      {"tagSupport", :tag_support} =>
        oneof([
          null(),
          map(%{
            {"valueSet", :value_set} => list(GenLSP.Enumerations.SymbolTag.schematic())
          })
        ]),
      {"labelSupport", :label_support} => oneof([null(), bool()])
    })
  end
end
