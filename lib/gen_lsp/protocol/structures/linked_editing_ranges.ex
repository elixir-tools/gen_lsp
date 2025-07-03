# codegen: do not edit
defmodule GenLSP.Structures.LinkedEditingRanges do
  @moduledoc """
  The result of a linked editing range request.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * ranges: A list of ranges that can be edited together. The ranges must have
    identical length and contain identical text content. The ranges cannot overlap.
  * word_pattern: An optional word pattern (regular expression) that describes valid contents for
    the given ranges. If no pattern is provided, the client configuration's word
    pattern will be used.
  """
  @derive Jason.Encoder
  typedstruct do
    field :ranges, list(GenLSP.Structures.Range.t()), enforce: true
    field :word_pattern, String.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"ranges", :ranges} => list(GenLSP.Structures.Range.schema()),
      optional({"wordPattern", :word_pattern}) => str()
    })
  end
end
