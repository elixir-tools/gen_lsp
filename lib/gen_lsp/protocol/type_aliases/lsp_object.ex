# codegen: do not edit
defmodule GenLSP.TypeAlias.LSPObject do
  @moduledoc """
  LSP object definition.
  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: %{String.t() => GenLSP.TypeAlias.LSPAny.t()}

  @doc false
  def schematic() do
    map(keys: str(), values: GenLSP.TypeAlias.LSPAny.schematic())
  end
end
