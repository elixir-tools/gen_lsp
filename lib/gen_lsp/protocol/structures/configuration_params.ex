# codegen: do not edit
defmodule GenLSP.Structures.ConfigurationParams do
  @moduledoc """
  The parameters of a configuration request.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * items
  """
  @derive Jason.Encoder
  typedstruct do
    field :items, list(GenLSP.Structures.ConfigurationItem.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"items", :items} => list(GenLSP.Structures.ConfigurationItem.schema())
    })
  end
end
