# codegen: do not edit
defmodule GenLSP.Structures.ConfigurationItem do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * scope_uri: The scope to get the configuration section for.
  * section: The configuration section asked for.
  """
  @derive Jason.Encoder
  typedstruct do
    field :scope_uri, String.t()
    field :section, String.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"scopeUri", :scope_uri} => nullable(str()),
      {"section", :section} => nullable(str())
    })
  end
end
