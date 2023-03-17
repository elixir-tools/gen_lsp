# codegen: do not edit
defmodule GenLSP.Enumerations.FoldingRangeKind do
  @moduledoc """
  A set of predefined range kinds.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * comment: Folding range for a comment
  * imports: Folding range for an import or include
  * region: Folding range for a region (e.g. `#region`)
  """
  @derive Jason.Encoder
  typedstruct do
    field :comment, String.t(), default: "comment"
    field :imports, String.t(), default: "imports"
    field :region, String.t(), default: "region"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("comment"),
      str("imports"),
      str("region")
    ])
  end
end
