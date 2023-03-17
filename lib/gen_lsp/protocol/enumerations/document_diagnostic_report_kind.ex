# codegen: do not edit
defmodule GenLSP.Enumerations.DocumentDiagnosticReportKind do
  @moduledoc """
  The document diagnostic report kinds.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * full: A diagnostic report with a full
    set of problems.
  * unchanged: A report indicating that the last
    returned report is still accurate.
  """
  @derive Jason.Encoder
  typedstruct do
    field :full, String.t(), default: "full"
    field :unchanged, String.t(), default: "unchanged"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("full"),
      str("unchanged")
    ])
  end
end
