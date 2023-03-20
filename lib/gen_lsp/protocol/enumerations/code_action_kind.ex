# codegen: do not edit
defmodule GenLSP.Enumerations.CodeActionKind do
  @moduledoc """
  A set of predefined code action kinds
  """

  import Schematic, warn: false

  @doc """
  Empty kind.
  """
  def empty, do: ""

  @doc """
  Base kind for quickfix actions: 'quickfix'
  """
  def quick_fix, do: "quickfix"

  @doc """
  Base kind for refactoring actions: 'refactor'
  """
  def refactor, do: "refactor"

  @doc """
  Base kind for refactoring extraction actions: 'refactor.extract'

  Example extract actions:

  - Extract method
  - Extract function
  - Extract variable
  - Extract interface from class
  - ...
  """
  def refactor_extract, do: "refactor.extract"

  @doc """
  Base kind for refactoring inline actions: 'refactor.inline'

  Example inline actions:

  - Inline function
  - Inline variable
  - Inline constant
  - ...
  """
  def refactor_inline, do: "refactor.inline"

  @doc """
  Base kind for refactoring rewrite actions: 'refactor.rewrite'

  Example rewrite actions:

  - Convert JavaScript function to class
  - Add or remove parameter
  - Encapsulate field
  - Make method static
  - Move method to base class
  - ...
  """
  def refactor_rewrite, do: "refactor.rewrite"

  @doc """
  Base kind for source actions: `source`

  Source code actions apply to the entire file.
  """
  def source, do: "source"

  @doc """
  Base kind for an organize imports source action: `source.organizeImports`
  """
  def source_organize_imports, do: "source.organizeImports"

  @doc """
  Base kind for auto-fix source actions: `source.fixAll`.

  Fix all actions automatically fix errors that have a clear fix that do not require user input.
  They should not suppress errors or perform unsafe fixes such as generating new types or classes.

  @since 3.15.0
  """
  def source_fix_all, do: "source.fixAll"

  @doc false
  def schematic() do
    oneof([
      str(""),
      str("quickfix"),
      str("refactor"),
      str("refactor.extract"),
      str("refactor.inline"),
      str("refactor.rewrite"),
      str("source"),
      str("source.organizeImports"),
      str("source.fixAll")
    ])
  end
end
