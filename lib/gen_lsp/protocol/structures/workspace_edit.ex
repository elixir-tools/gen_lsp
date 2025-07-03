# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceEdit do
  @moduledoc """
  A workspace edit represents changes to many resources managed in the workspace. The edit
  should either provide `changes` or `documentChanges`. If documentChanges are present
  they are preferred over `changes` if the client can handle versioned document edits.

  Since version 3.13.0 a workspace edit can contain resource operations as well. If resource
  operations are present clients need to execute the operations in the order in which they
  are provided. So a workspace edit for example can consist of the following two changes:
  (1) a create file a.txt and (2) a text document edit which insert text into file a.txt.

  An invalid sequence (e.g. (1) delete file a.txt and (2) insert text into file a.txt) will
  cause failure of the operation. How the client recovers from the failure is described by
  the client capability: `workspace.workspaceEdit.failureHandling`
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * changes: Holds changes to existing resources.
  * document_changes: Depending on the client capability `workspace.workspaceEdit.resourceOperations` document changes
    are either an array of `TextDocumentEdit`s to express changes to n different text documents
    where each text document edit addresses a specific version of a text document. Or it can contain
    above `TextDocumentEdit`s mixed with create, rename and delete file / folder operations.

    Whether a client supports versioned document edits is expressed via
    `workspace.workspaceEdit.documentChanges` client capability.

    If a client neither supports `documentChanges` nor `workspace.workspaceEdit.resourceOperations` then
    only plain `TextEdit`s using the `changes` property are supported.
  * change_annotations: A map of change annotations that can be referenced in `AnnotatedTextEdit`s or create, rename and
    delete file / folder operations.

    Whether clients honor this property depends on the client capability `workspace.changeAnnotationSupport`.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :changes, %{GenLSP.BaseTypes.document_uri() => list(GenLSP.Structures.TextEdit.t())}

    field :document_changes,
          list(
            GenLSP.Structures.TextDocumentEdit.t()
            | GenLSP.Structures.CreateFile.t()
            | GenLSP.Structures.RenameFile.t()
            | GenLSP.Structures.DeleteFile.t()
          )

    field :change_annotations, %{
      GenLSP.TypeAlias.ChangeAnnotationIdentifier.t() => GenLSP.Structures.ChangeAnnotation.t()
    }
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"changes", :changes}) =>
        map(keys: str(), values: list(GenLSP.Structures.TextEdit.schema())),
      optional({"documentChanges", :document_changes}) =>
        list(
          oneof([
            GenLSP.Structures.TextDocumentEdit.schema(),
            GenLSP.Structures.CreateFile.schema(),
            GenLSP.Structures.RenameFile.schema(),
            GenLSP.Structures.DeleteFile.schema()
          ])
        ),
      optional({"changeAnnotations", :change_annotations}) =>
        map(
          keys: GenLSP.TypeAlias.ChangeAnnotationIdentifier.schema(),
          values: GenLSP.Structures.ChangeAnnotation.schema()
        )
    })
  end
end
