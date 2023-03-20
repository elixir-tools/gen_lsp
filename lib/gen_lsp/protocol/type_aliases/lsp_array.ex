# codegen: do not edit
defmodule GenLSP.TypeAlias.LSPArray do
  @moduledoc """
  LSP arrays.
  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: list(any())

  @doc false
  def schematic() do
    list(any())
  end
end
