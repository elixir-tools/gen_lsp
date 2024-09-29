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
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"scopeUri", :scope_uri}) => str(),
      optional({"section", :section}) => str()
    })
  end
end
