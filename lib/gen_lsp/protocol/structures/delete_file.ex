# codegen: do not edit
defmodule GenLSP.Structures.DeleteFile do
  @moduledoc """
  Delete file operation
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * kind: A delete
  * uri: The file to delete.
  * options: Delete options.
  * annotation_id: An optional annotation identifier describing the operation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :kind, String.t(), enforce: true
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :options, GenLSP.Structures.DeleteFileOptions.t()
    field :annotation_id, GenLSP.TypeAlias.ChangeAnnotationIdentifier.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"kind", :kind} => str("delete"),
      {"uri", :uri} => str(),
      {"options", :options} => nullable(GenLSP.Structures.DeleteFileOptions.schematic()),
      {"annotationId", :annotation_id} =>
        nullable(GenLSP.TypeAlias.ChangeAnnotationIdentifier.schematic())
    })
  end
end
