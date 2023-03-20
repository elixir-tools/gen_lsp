# codegen: do not edit
defmodule GenLSP.Enumerations.InsertTextFormat do
  @moduledoc """
  Defines whether the insert text in a completion item should be interpreted as
  plain text or a snippet.
  """

  import Schematic, warn: false

  @doc """
  The primary text to be inserted is treated as a plain string.
  """
  def plain_text, do: 1

  @doc """
  The primary text to be inserted is treated as a snippet.

  A snippet can define tab stops and placeholders with `$1`, `$2`
  and `${3:foo}`. `$0` defines the final tab stop, it defaults to
  the end of the snippet. Placeholders with equal identifiers are linked,
  that is typing in one will update others too.

  See also: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#snippet_syntax
  """
  def snippet, do: 2

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
