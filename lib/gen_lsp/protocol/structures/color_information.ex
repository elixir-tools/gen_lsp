# codegen: do not edit
defmodule GenLSP.Structures.ColorInformation do
  @moduledoc """
  Represents a color range from a document.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The range in the document where this color appears.
  * color: The actual color value for this color range.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :color, GenLSP.Structures.Color.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      {"color", :color} => GenLSP.Structures.Color.schema()
    })
  end
end
