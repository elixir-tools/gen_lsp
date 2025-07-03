# codegen: do not edit
defmodule GenLSP.TypeAlias.LSPObject do
  @moduledoc """
  LSP object definition.
  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: %{String.t() => any()}

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    map(keys: str(), values: any())
  end
end
