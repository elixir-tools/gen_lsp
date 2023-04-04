# codegen: do not edit
defmodule GenLSP.Structures.SelectionRange do
  @moduledoc """
  A selection range represents a part of a selection hierarchy. A selection range
  may have a parent selection range that contains it.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The {@link Range range} of this selection range.
  * parent: The parent selection range containing this range. Therefore `parent.range` must contain `this.range`.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :parent, GenLSP.Structures.SelectionRange.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schematic(),
      {"parent", :parent} => nullable(GenLSP.Structures.SelectionRange.schematic())
    })
  end
end
