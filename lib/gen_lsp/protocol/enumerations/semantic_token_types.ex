# codegen: do not edit
defmodule GenLSP.Enumerations.SemanticTokenTypes do
  @moduledoc """
  A set of predefined token types. This set is not fixed
  an clients can specify additional token types via the
  corresponding client capabilities.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * namespace
  * type: Represents a generic type. Acts as a fallback for types which can't be mapped to
    a specific type like class or enum.
  * class
  * enum
  * interface
  * struct
  * type_parameter
  * parameter
  * variable
  * property
  * enum_member
  * event
  * function
  * method
  * macro
  * keyword
  * modifier
  * comment
  * string
  * number
  * regexp
  * operator
  * decorator: @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :namespace, String.t(), default: "namespace"
    field :type, String.t(), default: "type"
    field :class, String.t(), default: "class"
    field :enum, String.t(), default: "enum"
    field :interface, String.t(), default: "interface"
    field :struct, String.t(), default: "struct"
    field :type_parameter, String.t(), default: "typeParameter"
    field :parameter, String.t(), default: "parameter"
    field :variable, String.t(), default: "variable"
    field :property, String.t(), default: "property"
    field :enum_member, String.t(), default: "enumMember"
    field :event, String.t(), default: "event"
    field :function, String.t(), default: "function"
    field :method, String.t(), default: "method"
    field :macro, String.t(), default: "macro"
    field :keyword, String.t(), default: "keyword"
    field :modifier, String.t(), default: "modifier"
    field :comment, String.t(), default: "comment"
    field :string, String.t(), default: "string"
    field :number, String.t(), default: "number"
    field :regexp, String.t(), default: "regexp"
    field :operator, String.t(), default: "operator"
    field :decorator, String.t(), default: "decorator"
  end

  def v, do: %__MODULE__{}

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
