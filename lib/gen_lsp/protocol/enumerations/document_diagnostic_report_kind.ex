# codegen: do not edit
defmodule GenLSP.Enumerations.DocumentDiagnosticReportKind do
  @moduledoc """
  The document diagnostic report kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  @doc """
  A diagnostic report with a full
  set of problems.
  """
  def full, do: "full"

  @doc """
  A report indicating that the last
  returned report is still accurate.
  """
  def unchanged, do: "unchanged"

  @doc false
  def schematic() do
    oneof([
      str("full"),
      str("unchanged")
    ])
  end
end
