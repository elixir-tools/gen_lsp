# codegen: do not edit
defmodule GenLSP.Structures.DidChangeConfigurationRegistrationOptions do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * section
  """
  @derive Jason.Encoder
  typedstruct do
    field :section, String.t() | list(String.t())
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"section", :section} => nullable(oneof([str(), list(str())]))
    })
  end
end
