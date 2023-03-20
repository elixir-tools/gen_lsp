# codegen: do not edit
defmodule GenLSP.Structures.DocumentOnTypeFormattingOptions do
  @moduledoc """
  Provider options for a {@link DocumentOnTypeFormattingRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * first_trigger_character: A character on which formatting should be triggered, like `{`.
  * more_trigger_character: More trigger characters.
  """
  @derive Jason.Encoder
  typedstruct do
    field :first_trigger_character, String.t(), enforce: true
    field :more_trigger_character, list(String.t())
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"firstTriggerCharacter", :first_trigger_character} => str(),
      {"moreTriggerCharacter", :more_trigger_character} => oneof([null(), list(str())])
    })
  end
end
