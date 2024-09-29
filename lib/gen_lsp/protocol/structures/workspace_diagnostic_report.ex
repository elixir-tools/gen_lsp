# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceDiagnosticReport do
  @moduledoc """
  A workspace diagnostic report.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * items
  """
  @derive Jason.Encoder
  typedstruct do
    field :items, list(GenLSP.TypeAlias.WorkspaceDocumentDiagnosticReport.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"items", :items} => list(GenLSP.TypeAlias.WorkspaceDocumentDiagnosticReport.schema())
    })
  end
end
