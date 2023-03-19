# codegen: do not edit
defmodule GenLSP.Structures.SignatureHelpOptions do
  @moduledoc """
  Server Capabilities for a {@link SignatureHelpRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * trigger_characters: List of characters that trigger signature help automatically.
  * retrigger_characters: List of characters that re-trigger signature help.

    These trigger characters are only active when signature help is already showing. All trigger characters
    are also counted as re-trigger characters.

    @since 3.15.0
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :trigger_characters, list(String.t())
    field :retrigger_characters, list(String.t())
    field :work_done_progress, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"triggerCharacters", :trigger_characters} => oneof([null(), list(str())]),
      {"retriggerCharacters", :retrigger_characters} => oneof([null(), list(str())]),
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()])
    })
  end
end
