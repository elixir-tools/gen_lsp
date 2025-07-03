# codegen: do not edit
defmodule GenLSP.Structures.DocumentHighlight do
  @moduledoc """
  A document highlight is a range inside a text document which deserves
  special attention. Usually a document highlight is visualized by changing
  the background color of its range.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The range this highlight applies to.
  * kind: The highlight kind, default is {@link DocumentHighlightKind.Text text}.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :kind, GenLSP.Enumerations.DocumentHighlightKind.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      optional({"kind", :kind}) => GenLSP.Enumerations.DocumentHighlightKind.schema()
    })
  end
end
