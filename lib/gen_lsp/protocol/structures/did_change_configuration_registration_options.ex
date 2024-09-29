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
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"section", :section}) => oneof([str(), list(str())])
    })
  end
end
