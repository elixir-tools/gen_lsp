# codegen: do not edit
defmodule GenLSP.Structures.InlineValueText do
  @moduledoc """
  Provide inline value as text.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The document range for which the inline value applies.
  * text: The text of the inline value.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :text, String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      {"text", :text} => str()
    })
  end
end
