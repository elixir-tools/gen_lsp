# codegen: do not edit
defmodule GenLSP.Structures.SetTraceParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * value
  """
  @derive Jason.Encoder
  typedstruct do
    field :value, GenLSP.Enumerations.TraceValues.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"value", :value} => GenLSP.Enumerations.TraceValues.schema()
    })
  end
end
