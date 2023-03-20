# codegen: do not edit
defmodule GenLSP.Enumerations.SemanticTokenTypes do
  @moduledoc """
  A set of predefined token types. This set is not fixed
  an clients can specify additional token types via the
  corresponding client capabilities.

  @since 3.16.0
  """

  import Schematic, warn: false

  def namespace, do: "namespace"

  @doc """
  Represents a generic type. Acts as a fallback for types which can't be mapped to
  a specific type like class or enum.
  """
  def type, do: "type"

  def class, do: "class"

  def enum, do: "enum"

  def interface, do: "interface"

  def struct, do: "struct"

  def type_parameter, do: "typeParameter"

  def parameter, do: "parameter"

  def variable, do: "variable"

  def property, do: "property"

  def enum_member, do: "enumMember"

  def event, do: "event"

  def function, do: "function"

  def method, do: "method"

  def macro, do: "macro"

  def keyword, do: "keyword"

  def modifier, do: "modifier"

  def comment, do: "comment"

  def string, do: "string"

  def number, do: "number"

  def regexp, do: "regexp"

  def operator, do: "operator"

  @doc """
  @since 3.17.0
  """
  def decorator, do: "decorator"

  @doc false
  def schematic() do
    oneof([
      str("namespace"),
      str("type"),
      str("class"),
      str("enum"),
      str("interface"),
      str("struct"),
      str("typeParameter"),
      str("parameter"),
      str("variable"),
      str("property"),
      str("enumMember"),
      str("event"),
      str("function"),
      str("method"),
      str("macro"),
      str("keyword"),
      str("modifier"),
      str("comment"),
      str("string"),
      str("number"),
      str("regexp"),
      str("operator"),
      str("decorator")
    ])
  end
end
