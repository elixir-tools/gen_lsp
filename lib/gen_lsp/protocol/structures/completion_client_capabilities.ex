# codegen: do not edit
defmodule GenLSP.Structures.CompletionClientCapabilities do
  @moduledoc """
  Completion client capabilities
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether completion supports dynamic registration.
  * completion_item: The client supports the following `CompletionItem` specific
    capabilities.
  * completion_item_kind
  * insert_text_mode: Defines how the client handles whitespace and indentation
    when accepting a completion item that uses multi line
    text in either `insertText` or `textEdit`.

    @since 3.17.0
  * context_support: The client supports to send additional context information for a
    `textDocument/completion` request.
  * completion_list: The client supports the following `CompletionList` specific
    capabilities.

    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :completion_item, map()
    field :completion_item_kind, map()
    field :insert_text_mode, GenLSP.Enumerations.InsertTextMode.t()
    field :context_support, boolean()
    field :completion_list, map()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"completionItem", :completion_item} =>
        oneof([
          null(),
          map(%{
            {"snippetSupport", :snippet_support} => oneof([null(), bool()]),
            {"commitCharactersSupport", :commit_characters_support} => oneof([null(), bool()]),
            {"documentationFormat", :documentation_format} =>
              oneof([null(), list(GenLSP.Enumerations.MarkupKind.schematic())]),
            {"deprecatedSupport", :deprecated_support} => oneof([null(), bool()]),
            {"preselectSupport", :preselect_support} => oneof([null(), bool()]),
            {"tagSupport", :tag_support} =>
              oneof([
                null(),
                map(%{
                  {"valueSet", :value_set} =>
                    list(GenLSP.Enumerations.CompletionItemTag.schematic())
                })
              ]),
            {"insertReplaceSupport", :insert_replace_support} => oneof([null(), bool()]),
            {"resolveSupport", :resolve_support} =>
              oneof([
                null(),
                map(%{
                  {"properties", :properties} => list(str())
                })
              ]),
            {"insertTextModeSupport", :insert_text_mode_support} =>
              oneof([
                null(),
                map(%{
                  {"valueSet", :value_set} => list(GenLSP.Enumerations.InsertTextMode.schematic())
                })
              ]),
            {"labelDetailsSupport", :label_details_support} => oneof([null(), bool()])
          })
        ]),
      {"completionItemKind", :completion_item_kind} =>
        oneof([
          null(),
          map(%{
            {"valueSet", :value_set} =>
              oneof([null(), list(GenLSP.Enumerations.CompletionItemKind.schematic())])
          })
        ]),
      {"insertTextMode", :insert_text_mode} =>
        oneof([null(), GenLSP.Enumerations.InsertTextMode.schematic()]),
      {"contextSupport", :context_support} => oneof([null(), bool()]),
      {"completionList", :completion_list} =>
        oneof([
          null(),
          map(%{
            {"itemDefaults", :item_defaults} => oneof([null(), list(str())])
          })
        ])
    })
  end
end
