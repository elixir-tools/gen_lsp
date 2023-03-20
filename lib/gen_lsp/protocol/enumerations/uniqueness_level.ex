# codegen: do not edit
defmodule GenLSP.Enumerations.UniquenessLevel do
  @moduledoc """
  Moniker uniqueness level to define scope of the moniker.

  @since 3.16.0
  """

  import Schematic, warn: false

  @doc """
  The moniker is only unique inside a document
  """
  def document, do: "document"

  @doc """
  The moniker is unique inside a project for which a dump got created
  """
  def project, do: "project"

  @doc """
  The moniker is unique inside the group to which a project belongs
  """
  def group, do: "group"

  @doc """
  The moniker is unique inside the moniker scheme.
  """
  def scheme, do: "scheme"

  @doc """
  The moniker is globally unique
  """
  def global, do: "global"

  @doc false
  def schematic() do
    oneof([
      str("document"),
      str("project"),
      str("group"),
      str("scheme"),
      str("global")
    ])
  end
end
