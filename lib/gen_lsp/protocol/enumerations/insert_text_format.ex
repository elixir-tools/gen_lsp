# codegen: do not edit
defmodule GenLSP.Enumerations.InsertTextFormat do
  @moduledoc """
  Defines whether the insert text in a completion item should be interpreted as
  plain text or a snippet.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * plain_text: The primary text to be inserted is treated as a plain string.
  * snippet: The primary text to be inserted is treated as a snippet.
    
    A snippet can define tab stops and placeholders with `$1`, `$2`
    and `${3:foo}`. `$0` defines the final tab stop, it defaults to
    the end of the snippet. Placeholders with equal identifiers are linked,
    that is typing in one will update others too.
    
    See also: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#snippet_syntax
  """
  @derive Jason.Encoder
  typedstruct do
    field :plain_text, GenLSP.BaseTypes.uinteger(), default: 1
    field :snippet, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
