# codegen: do not edit
defmodule GenLSP.Structures.ResourceOperation do
  @moduledoc """
  A generic resource operation.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * kind: The resource operation kind.
  * annotation_id: An optional annotation identifier describing the operation.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :kind, String.t(), enforce: true
    field :annotation_id, GenLSP.TypeAlias.ChangeAnnotationIdentifier.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"kind", :kind} => str(),
      optional({"annotationId", :annotation_id}) =>
        GenLSP.TypeAlias.ChangeAnnotationIdentifier.schema()
    })
  end
end
