# codegen: do not edit
defmodule GenLSP.Enumerations.PositionEncodingKind do
  @moduledoc """
  A set of predefined position encoding kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * utf8: Character offsets count UTF-8 code units.
  * utf16: Character offsets count UTF-16 code units.
    
    This is the default and must always be supported
    by servers
  * utf32: Character offsets count UTF-32 code units.
    
    Implementation note: these are the same as Unicode code points,
    so this `PositionEncodingKind` may also be used for an
    encoding-agnostic representation of character offsets.
  """
  @derive Jason.Encoder
  typedstruct do
    field :utf8, String.t(), default: "utf-8"
    field :utf16, String.t(), default: "utf-16"
    field :utf32, String.t(), default: "utf-32"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("utf-8"),
      str("utf-16"),
      str("utf-32")
    ])
  end
end
