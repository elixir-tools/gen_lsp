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
      {"dynamicRegistration", :dynamic_registration} => nullable(bool()),
      {"completionItem", :completion_item} =>
        nullable(
          map(%{
            {"snippetSupport", :snippet_support} => nullable(bool()),
            {"commitCharactersSupport", :commit_characters_support} => nullable(bool()),
            {"documentationFormat", :documentation_format} =>
              nullable(list(GenLSP.Enumerations.MarkupKind.schematic())),
            {"deprecatedSupport", :deprecated_support} => nullable(bool()),
            {"preselectSupport", :preselect_support} => nullable(bool()),
            {"tagSupport", :tag_support} =>
              nullable(
                map(%{
                  {"valueSet", :value_set} =>
                    list(GenLSP.Enumerations.CompletionItemTag.schematic())
                })
              ),
            {"insertReplaceSupport", :insert_replace_support} => nullable(bool()),
            {"resolveSupport", :resolve_support} =>
              nullable(
                map(%{
                  {"properties", :properties} => list(str())
                })
              ),
            {"insertTextModeSupport", :insert_text_mode_support} =>
              nullable(
                map(%{
                  {"valueSet", :value_set} => list(GenLSP.Enumerations.InsertTextMode.schematic())
                })
              ),
            {"labelDetailsSupport", :label_details_support} => nullable(bool())
          })
        ),
      {"completionItemKind", :completion_item_kind} =>
        nullable(
          map(%{
            {"valueSet", :value_set} =>
              nullable(list(GenLSP.Enumerations.CompletionItemKind.schematic()))
          })
        ),
      {"insertTextMode", :insert_text_mode} =>
        nullable(GenLSP.Enumerations.InsertTextMode.schematic()),
      {"contextSupport", :context_support} => nullable(bool()),
      {"completionList", :completion_list} =>
        nullable(
          map(%{
            {"itemDefaults", :item_defaults} => nullable(list(str()))
          })
        )
    })
  end
end
