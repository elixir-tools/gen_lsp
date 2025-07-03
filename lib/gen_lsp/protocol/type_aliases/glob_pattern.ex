# codegen: do not edit
defmodule GenLSP.TypeAlias.GlobPattern do
  @moduledoc """
  The glob pattern. Either a string pattern or a relative pattern.

  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: GenLSP.TypeAlias.Pattern.t() | GenLSP.Structures.RelativePattern.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([GenLSP.TypeAlias.Pattern.schema(), GenLSP.Structures.RelativePattern.schema()])
  end
end
