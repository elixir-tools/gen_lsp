# codegen: do not edit
defmodule GenLSP.Structures.CancelParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The request id to cancel.
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, integer() | String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"id", :id} => oneof([int(), str()])
    })
  end
end
