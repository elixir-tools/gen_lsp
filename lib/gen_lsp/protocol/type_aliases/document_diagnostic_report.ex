# codegen: do not edit
defmodule GenLSP.TypeAlias.DocumentDiagnosticReport do
  @moduledoc """
  The result of a document diagnostic pull request. A report can
  either be a full report containing all diagnostics for the
  requested document or an unchanged report indicating that nothing
  has changed in terms of diagnostics in comparison to the last
  pull request.

  @since 3.17.0
  """

  import Schematic, warn: false

  @type t ::
          GenLSP.Structures.RelatedFullDocumentDiagnosticReport.t()
          | GenLSP.Structures.RelatedUnchangedDocumentDiagnosticReport.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      GenLSP.Structures.RelatedFullDocumentDiagnosticReport.schema(),
      GenLSP.Structures.RelatedUnchangedDocumentDiagnosticReport.schema()
    ])
  end
end
