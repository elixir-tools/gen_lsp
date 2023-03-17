# codegen: do not edit
defmodule GenLSP.Enumerations.MonikerKind do
  @moduledoc """
  The moniker kind.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * import: The moniker represent a symbol that is imported into a project
  * export: The moniker represents a symbol that is exported from a project
  * local: The moniker represents a symbol that is local to a project (e.g. a local
    variable of a function, a class not visible outside the project, ...)
  """
  @derive Jason.Encoder
  typedstruct do
    field :import, String.t(), default: "import"
    field :export, String.t(), default: "export"
    field :local, String.t(), default: "local"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("import"),
      str("export"),
      str("local")
    ])
  end
end
