# codegen: do not edit
defmodule GenLSP.Enumerations.SemanticTokenModifiers do
  @moduledoc """
  A set of predefined token modifiers. This set is not fixed
  an clients can specify additional token types via the
  corresponding client capabilities.

  @since 3.16.0
  """

  import Schematic, warn: false

  def declaration, do: "declaration"

  def definition, do: "definition"

  def readonly, do: "readonly"

  def static, do: "static"

  def deprecated, do: "deprecated"

  def abstract, do: "abstract"

  def async, do: "async"

  def modification, do: "modification"

  def documentation, do: "documentation"

  def default_library, do: "defaultLibrary"

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
