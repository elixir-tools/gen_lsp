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

  @type t ::
          GenLSP.TypeAlias.LSPObject.t()
          | GenLSP.TypeAlias.LSPArray.t()
          | String.t()
          | integer()
          | GenLSP.BaseTypes.uinteger()
          | float()
          | boolean()
          | nil

  @doc false
  def schematic() do
    oneof([
      GenLSP.TypeAlias.LSPObject.schematic(),
      GenLSP.TypeAlias.LSPArray.schematic(),
      str(),
      int(),
      int(),
      str(),
      bool(),
      null()
    ])
  end
end
