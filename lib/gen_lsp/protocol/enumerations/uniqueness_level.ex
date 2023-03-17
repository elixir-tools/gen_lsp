# codegen: do not edit
defmodule GenLSP.Enumerations.UniquenessLevel do
  @moduledoc """
  Moniker uniqueness level to define scope of the moniker.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * document: The moniker is only unique inside a document
  * project: The moniker is unique inside a project for which a dump got created
  * group: The moniker is unique inside the group to which a project belongs
  * scheme: The moniker is unique inside the moniker scheme.
  * global: The moniker is globally unique
  """
  @derive Jason.Encoder
  typedstruct do
    field :document, String.t(), default: "document"
    field :project, String.t(), default: "project"
    field :group, String.t(), default: "group"
    field :scheme, String.t(), default: "scheme"
    field :global, String.t(), default: "global"
  end

  def v, do: %__MODULE__{}

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
