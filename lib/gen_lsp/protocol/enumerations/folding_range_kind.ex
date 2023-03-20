# codegen: do not edit
defmodule GenLSP.Enumerations.FoldingRangeKind do
  @moduledoc """
  A set of predefined range kinds.
  """

  import Schematic, warn: false

  @doc """
  Folding range for a comment
  """
  def comment, do: "comment"

  @doc """
  Folding range for an import or include
  """
  def imports, do: "imports"

  @doc """
  Folding range for a region (e.g. `#region`)
  """
  def region, do: "region"

  @doc false
  def schematic() do
    oneof([
      str("comment"),
      str("imports"),
      str("region")
    ])
  end
end
