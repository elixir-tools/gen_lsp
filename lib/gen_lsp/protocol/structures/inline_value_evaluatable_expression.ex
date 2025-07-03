# codegen: do not edit
defmodule GenLSP.Structures.InlineValueEvaluatableExpression do
  @moduledoc """
  Provide an inline value through an expression evaluation.
  If only a range is specified, the expression will be extracted from the underlying document.
  An optional expression can be used to override the extracted expression.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The document range for which the inline value applies.
    The range is used to extract the evaluatable expression from the underlying document.
  * expression: If specified the expression overrides the extracted expression.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :expression, String.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      optional({"expression", :expression}) => str()
    })
  end
end
