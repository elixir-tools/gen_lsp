# codegen: do not edit
defmodule GenLSP.Structures.DidChangeConfigurationParams do
  @moduledoc """
  The parameters of a change configuration notification.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * settings: The actual changed settings
  """
  @derive Jason.Encoder
  typedstruct do
    field :settings, GenLSP.TypeAlias.LSPAny.t(), enforce: true
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"settings", :settings} => GenLSP.TypeAlias.LSPAny.schematic()
    })
  end
end
