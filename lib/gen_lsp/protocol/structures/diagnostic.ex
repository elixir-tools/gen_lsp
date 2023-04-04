# codegen: do not edit
defmodule GenLSP.Structures.Diagnostic do
  @moduledoc """
  Represents a diagnostic, such as a compiler error or warning. Diagnostic objects
  are only valid in the scope of a resource.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The range at which the message applies
  * severity: The diagnostic's severity. Can be omitted. If omitted it is up to the
    client to interpret diagnostics as error, warning, info or hint.
  * code: The diagnostic's code, which usually appear in the user interface.
  * code_description: An optional property to describe the error code.
    Requires the code field (above) to be present/not null.

    @since 3.16.0
  * source: A human-readable string describing the source of this
    diagnostic, e.g. 'typescript' or 'super lint'. It usually
    appears in the user interface.
  * message: The diagnostic's message. It usually appears in the user interface
  * tags: Additional metadata about the diagnostic.

    @since 3.15.0
  * related_information: An array of related diagnostic information, e.g. when symbol-names within
    a scope collide all definitions can be marked via this property.
  * data: A data entry field that is preserved between a `textDocument/publishDiagnostics`
    notification and `textDocument/codeAction` request.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :severity, GenLSP.Enumerations.DiagnosticSeverity.t()
    field :code, integer() | String.t()
    field :code_description, GenLSP.Structures.CodeDescription.t()
    field :source, String.t()
    field :message, String.t(), enforce: true
    field :tags, list(GenLSP.Enumerations.DiagnosticTag.t())
    field :related_information, list(GenLSP.Structures.DiagnosticRelatedInformation.t())
    field :data, GenLSP.TypeAlias.LSPAny.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schematic(),
      {"severity", :severity} => nullable(GenLSP.Enumerations.DiagnosticSeverity.schematic()),
      {"code", :code} => nullable(oneof([int(), str()])),
      {"codeDescription", :code_description} =>
        nullable(GenLSP.Structures.CodeDescription.schematic()),
      {"source", :source} => nullable(str()),
      {"message", :message} => str(),
      {"tags", :tags} => nullable(list(GenLSP.Enumerations.DiagnosticTag.schematic())),
      {"relatedInformation", :related_information} =>
        nullable(list(GenLSP.Structures.DiagnosticRelatedInformation.schematic())),
      {"data", :data} => nullable(GenLSP.TypeAlias.LSPAny.schematic())
    })
  end
end
