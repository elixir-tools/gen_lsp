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
  def schematic() do
    schema(__MODULE__, %{
      {"section", :section} => oneof([null(), oneof([str(), list(str())])])
    })
  end
end
