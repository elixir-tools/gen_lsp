# codegen: do not edit
defmodule GenLSP.Enumerations.PositionEncodingKind do
  @moduledoc """
  A set of predefined position encoding kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  @doc """
  Character offsets count UTF-8 code units.
  """
  def utf8, do: "utf-8"

  @doc """
  Character offsets count UTF-16 code units.

  This is the default and must always be supported
  by servers
  """
  def utf16, do: "utf-16"

  @doc """
  Character offsets count UTF-32 code units.

  Implementation note: these are the same as Unicode code points,
  so this `PositionEncodingKind` may also be used for an
  encoding-agnostic representation of character offsets.
  """
  def utf32, do: "utf-32"

  @doc false
  def schematic() do
    oneof([
      str("utf-8"),
      str("utf-16"),
      str("utf-32")
    ])
  end
end
