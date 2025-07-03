# codegen: do not edit
defmodule GenLSP.TypeAlias.Definition do
  @moduledoc """
  The definition of a symbol represented as one or many {@link Location locations}.
  For most programming languages there is only one location at which a symbol is
  defined.

  Servers should prefer returning `DefinitionLink` over `Definition` if supported
  by the client.
  """

  import Schematic, warn: false

  @type t :: GenLSP.Structures.Location.t() | list(GenLSP.Structures.Location.t())

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([GenLSP.Structures.Location.schema(), list(GenLSP.Structures.Location.schema())])
  end
end
