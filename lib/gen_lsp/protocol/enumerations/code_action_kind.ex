# codegen: do not edit
defmodule GenLSP.Enumerations.CodeActionKind do
  @moduledoc """
  A set of predefined code action kinds
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * empty: Empty kind.
  * quick_fix: Base kind for quickfix actions: 'quickfix'
  * refactor: Base kind for refactoring actions: 'refactor'
  * refactor_extract: Base kind for refactoring extraction actions: 'refactor.extract'
    
    Example extract actions:
    
    - Extract method
    - Extract function
    - Extract variable
    - Extract interface from class
    - ...
  * refactor_inline: Base kind for refactoring inline actions: 'refactor.inline'
    
    Example inline actions:
    
    - Inline function
    - Inline variable
    - Inline constant
    - ...
  * refactor_rewrite: Base kind for refactoring rewrite actions: 'refactor.rewrite'
    
    Example rewrite actions:
    
    - Convert JavaScript function to class
    - Add or remove parameter
    - Encapsulate field
    - Make method static
    - Move method to base class
    - ...
  * source: Base kind for source actions: `source`
    
    Source code actions apply to the entire file.
  * source_organize_imports: Base kind for an organize imports source action: `source.organizeImports`
  * source_fix_all: Base kind for auto-fix source actions: `source.fixAll`.
    
    Fix all actions automatically fix errors that have a clear fix that do not require user input.
    They should not suppress errors or perform unsafe fixes such as generating new types or classes.
    
    @since 3.15.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :empty, String.t(), default: ""
    field :quick_fix, String.t(), default: "quickfix"
    field :refactor, String.t(), default: "refactor"
    field :refactor_extract, String.t(), default: "refactor.extract"
    field :refactor_inline, String.t(), default: "refactor.inline"
    field :refactor_rewrite, String.t(), default: "refactor.rewrite"
    field :source, String.t(), default: "source"
    field :source_organize_imports, String.t(), default: "source.organizeImports"
    field :source_fix_all, String.t(), default: "source.fixAll"
  end

  def v, do: %__MODULE__{}

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
