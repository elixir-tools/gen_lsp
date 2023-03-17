# codegen: do not edit
defmodule GenLSP.TypeAlias.LSPArray do
  @moduledoc """
  LSP arrays.
  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: list(GenLSP.TypeAlias.LSPAny.t())

  @doc false
  def schematic() do
    list(GenLSP.TypeAlias.LSPAny.schematic())
  end
end
