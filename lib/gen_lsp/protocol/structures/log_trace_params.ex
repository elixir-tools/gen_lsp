# codegen: do not edit
defmodule GenLSP.Structures.LogTraceParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * message
  * verbose
  """
  @derive Jason.Encoder
  typedstruct do
    field :message, String.t(), enforce: true
    field :verbose, String.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"message", :message} => str(),
      {"verbose", :verbose} => nullable(str())
    })
  end
end
