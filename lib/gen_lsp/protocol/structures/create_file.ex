# codegen: do not edit
defmodule GenLSP.Structures.CreateFile do
  @moduledoc """
  Create file operation.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * kind: A create
  * uri: The resource to create.
  * options: Additional options
  * annotation_id: An optional annotation identifier describing the operation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :kind, String.t(), enforce: true
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :options, GenLSP.Structures.CreateFileOptions.t()
    field :annotation_id, GenLSP.TypeAlias.ChangeAnnotationIdentifier.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"kind", :kind} => "create",
      {"uri", :uri} => str(),
      optional({"options", :options}) => GenLSP.Structures.CreateFileOptions.schema(),
      optional({"annotationId", :annotation_id}) =>
        GenLSP.TypeAlias.ChangeAnnotationIdentifier.schema()
    })
  end
end
