# codegen: do not edit
defmodule GenLSP.TypeAlias.DefinitionLink do
  @moduledoc """
  Information about where a symbol is defined.

  Provides additional metadata over normal {@link Location location} definitions, including the range of
  the defining symbol
  """

  import Schematic, warn: false

  @type t :: GenLSP.Structures.LocationLink.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    GenLSP.Structures.LocationLink.schema()
  end
end
