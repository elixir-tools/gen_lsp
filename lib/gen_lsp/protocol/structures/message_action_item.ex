# codegen: do not edit
defmodule GenLSP.Structures.MessageActionItem do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * title: A short title like 'Retry', 'Open Log' etc.
  """
  @derive Jason.Encoder
  typedstruct do
    field :title, String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"title", :title} => str()
    })
  end
end
