# codegen: do not edit
defmodule GenLSP.Structures.CompletionOptions do
  @moduledoc """
  Completion options.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * trigger_characters: Most tools trigger completion request automatically without explicitly requesting
    it using a keyboard shortcut (e.g. Ctrl+Space). Typically they do so when the user
    starts to type an identifier. For example if the user types `c` in a JavaScript file
    code complete will automatically pop up present `console` besides others as a
    completion item. Characters that make up identifiers don't need to be listed here.

    If code complete should automatically be trigger on characters not being valid inside
    an identifier (for example `.` in JavaScript) list them in `triggerCharacters`.
  * all_commit_characters: The list of all possible characters that commit a completion. This field can be used
    if clients don't support individual commit characters per completion item. See
    `ClientCapabilities.textDocument.completion.completionItem.commitCharactersSupport`

    If a server provides both `allCommitCharacters` and commit characters on an individual
    completion item the ones on the completion item win.

    @since 3.2.0
  * resolve_provider: The server provides support to resolve additional
    information for a completion item.
  * completion_item: The server supports the following `CompletionItem` specific
    capabilities.

    @since 3.17.0
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :trigger_characters, list(String.t())
    field :all_commit_characters, list(String.t())
    field :resolve_provider, boolean()
    field :completion_item, map()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"triggerCharacters", :trigger_characters} => oneof([null(), list(str())]),
      {"allCommitCharacters", :all_commit_characters} => oneof([null(), list(str())]),
      {"resolveProvider", :resolve_provider} => oneof([null(), bool()]),
      {"completionItem", :completion_item} =>
        oneof([
          null(),
          map(%{
            {"labelDetailsSupport", :label_details_support} => oneof([null(), bool()])
          })
        ]),
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()])
    })
  end
end
