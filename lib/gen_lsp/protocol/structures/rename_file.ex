# codegen: do not edit
defmodule GenLSP.Structures.RenameFile do
  @moduledoc """
  Rename file operation
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * kind: A rename
  * old_uri: The old (existing) location.
  * new_uri: The new location.
  * options: Rename options.
  * annotation_id: An optional annotation identifier describing the operation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :kind, String.t(), enforce: true
    field :old_uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :new_uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :options, GenLSP.Structures.RenameFileOptions.t()
    field :annotation_id, GenLSP.TypeAlias.ChangeAnnotationIdentifier.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"kind", :kind} => "rename",
      {"oldUri", :old_uri} => str(),
      {"newUri", :new_uri} => str(),
      optional({"options", :options}) => GenLSP.Structures.RenameFileOptions.schema(),
      optional({"annotationId", :annotation_id}) =>
        GenLSP.TypeAlias.ChangeAnnotationIdentifier.schema()
    })
  end
end
