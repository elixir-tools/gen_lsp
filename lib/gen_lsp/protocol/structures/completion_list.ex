# codegen: do not edit
defmodule GenLSP.Structures.CompletionList do
  @moduledoc """
  Represents a collection of {@link CompletionItem completion items} to be presented
  in the editor.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * is_incomplete: This list it not complete. Further typing results in recomputing this list.

    Recomputed lists have all their items replaced (not appended) in the
    incomplete completion sessions.
  * item_defaults: In many cases the items of an actual completion result share the same
    value for properties like `commitCharacters` or the range of a text
    edit. A completion list can therefore define item defaults which will
    be used if a completion item itself doesn't specify the value.

    If a completion list specifies a default value and a completion item
    also specifies a corresponding value the one from the item is used.

    Servers are only allowed to return default values if the client
    signals support for this via the `completionList.itemDefaults`
    capability.

    @since 3.17.0
  * items: The completion items.
  """
  @derive Jason.Encoder
  typedstruct do
    field :is_incomplete, boolean(), enforce: true
    field :item_defaults, map()
    field :items, list(GenLSP.Structures.CompletionItem.t()), enforce: true
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"isIncomplete", :is_incomplete} => bool(),
      {"itemDefaults", :item_defaults} =>
        oneof([
          null(),
          map(%{
            {"commitCharacters", :commit_characters} => oneof([null(), list(str())]),
            {"editRange", :edit_range} =>
              oneof([
                null(),
                oneof([
                  GenLSP.Structures.Range.schematic(),
                  map(%{
                    {"insert", :insert} => GenLSP.Structures.Range.schematic(),
                    {"replace", :replace} => GenLSP.Structures.Range.schematic()
                  })
                ])
              ]),
            {"insertTextFormat", :insert_text_format} =>
              oneof([null(), GenLSP.Enumerations.InsertTextFormat.schematic()]),
            {"insertTextMode", :insert_text_mode} =>
              oneof([null(), GenLSP.Enumerations.InsertTextMode.schematic()]),
            {"data", :data} => oneof([null(), GenLSP.TypeAlias.LSPAny.schematic()])
          })
        ]),
      {"items", :items} => list(GenLSP.Structures.CompletionItem.schematic())
    })
  end
end
