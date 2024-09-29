# codegen: do not edit
defmodule GenLSP.Structures.AnnotatedTextEdit do
  @moduledoc """
  A special text edit with an additional change annotation.

  @since 3.16.0.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * annotation_id: The actual identifier of the change annotation
  * range: The range of the text document to be manipulated. To insert
    text into a document create a range where start === end.
  * new_text: The string to be inserted. For delete operations use an
    empty string.
  """
  @derive Jason.Encoder
  typedstruct do
    field :annotation_id, GenLSP.TypeAlias.ChangeAnnotationIdentifier.t(), enforce: true
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :new_text, String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"annotationId", :annotation_id} => GenLSP.TypeAlias.ChangeAnnotationIdentifier.schema(),
      {"range", :range} => GenLSP.Structures.Range.schema(),
      {"newText", :new_text} => str()
    })
  end
end
