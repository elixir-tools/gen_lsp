# codegen: do not edit
defmodule GenLSP.TypeAlias.DeclarationLink do
  @moduledoc """
  Information about where a symbol is declared.

  Provides additional metadata over normal {@link Location location} declarations, including the range of
  the declaring symbol.

  Servers should prefer returning `DeclarationLink` over `Declaration` if supported
  by the client.
  """

  import Schematic, warn: false

  @type t :: GenLSP.Structures.LocationLink.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    GenLSP.Structures.LocationLink.schema()
  end
end
