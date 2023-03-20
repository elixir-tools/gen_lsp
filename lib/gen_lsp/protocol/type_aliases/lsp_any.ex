# codegen: do not edit
defmodule GenLSP.TypeAlias.LSPAny do
  @moduledoc """
  The LSP any type.
  Please note that strictly speaking a property with the value `undefined`
  can't be converted into JSON preserving the property name. However for
  convenience it is allowed and assumed that all these properties are
  optional as well.
  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: any()

  @doc false
  def schematic() do
    any()
  end
end
