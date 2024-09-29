# codegen: do not edit
defmodule GenLSP.Structures.Hover do
  @moduledoc """
  The result of a hover request.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * contents: The hover's content
  * range: An optional range inside the text document that is used to
    visualize the hover, e.g. by changing the background color.
  """
  @derive Jason.Encoder
  typedstruct do
    field :contents,
          GenLSP.Structures.MarkupContent.t()
          | GenLSP.TypeAlias.MarkedString.t()
          | list(GenLSP.TypeAlias.MarkedString.t()),
          enforce: true

    field :range, GenLSP.Structures.Range.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"contents", :contents} =>
        oneof([
          GenLSP.Structures.MarkupContent.schema(),
          GenLSP.TypeAlias.MarkedString.schema(),
          list(GenLSP.TypeAlias.MarkedString.schema())
        ]),
      optional({"range", :range}) => GenLSP.Structures.Range.schema()
    })
  end
end
