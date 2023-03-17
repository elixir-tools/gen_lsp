# codegen: do not edit
defmodule GenLSP.Enumerations.SemanticTokenModifiers do
  @moduledoc """
  A set of predefined token modifiers. This set is not fixed
  an clients can specify additional token types via the
  corresponding client capabilities.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * declaration
  * definition
  * readonly
  * static
  * deprecated
  * abstract
  * async
  * modification
  * documentation
  * default_library
  """
  @derive Jason.Encoder
  typedstruct do
    field :declaration, String.t(), default: "declaration"
    field :definition, String.t(), default: "definition"
    field :readonly, String.t(), default: "readonly"
    field :static, String.t(), default: "static"
    field :deprecated, String.t(), default: "deprecated"
    field :abstract, String.t(), default: "abstract"
    field :async, String.t(), default: "async"
    field :modification, String.t(), default: "modification"
    field :documentation, String.t(), default: "documentation"
    field :default_library, String.t(), default: "defaultLibrary"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("declaration"),
      str("definition"),
      str("readonly"),
      str("static"),
      str("deprecated"),
      str("abstract"),
      str("async"),
      str("modification"),
      str("documentation"),
      str("defaultLibrary")
    ])
  end
end
