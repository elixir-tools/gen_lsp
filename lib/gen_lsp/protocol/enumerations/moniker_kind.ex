# codegen: do not edit
defmodule GenLSP.Enumerations.MonikerKind do
  @moduledoc """
  The moniker kind.

  @since 3.16.0
  """

  import Schematic, warn: false

  @doc """
  The moniker represent a symbol that is imported into a project
  """
  def import, do: "import"

  @doc """
  The moniker represents a symbol that is exported from a project
  """
  def export, do: "export"

  @doc """
  The moniker represents a symbol that is local to a project (e.g. a local
  variable of a function, a class not visible outside the project, ...)
  """
  def local, do: "local"

  @doc false
  def schematic() do
    oneof([
      str("import"),
      str("export"),
      str("local")
    ])
  end
end
