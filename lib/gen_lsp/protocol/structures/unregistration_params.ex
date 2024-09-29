# codegen: do not edit
defmodule GenLSP.Structures.UnregistrationParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * unregisterations
  """
  @derive Jason.Encoder
  typedstruct do
    field :unregisterations, list(GenLSP.Structures.Unregistration.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"unregisterations", :unregisterations} => list(GenLSP.Structures.Unregistration.schema())
    })
  end
end
