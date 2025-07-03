# codegen: do not edit
defmodule GenLSP.Structures.DocumentDiagnosticReportPartialResult do
  @moduledoc """
  A partial result for a document diagnostic report.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * related_documents
  """
  @derive Jason.Encoder
  typedstruct do
    field :related_documents,
          %{
            GenLSP.BaseTypes.document_uri() =>
              GenLSP.Structures.FullDocumentDiagnosticReport.t()
              | GenLSP.Structures.UnchangedDocumentDiagnosticReport.t()
          },
          enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"relatedDocuments", :related_documents} =>
        map(
          keys: str(),
          values:
            oneof([
              GenLSP.Structures.FullDocumentDiagnosticReport.schema(),
              GenLSP.Structures.UnchangedDocumentDiagnosticReport.schema()
            ])
        )
    })
  end
end
