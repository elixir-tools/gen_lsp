# codegen: do not edit
defmodule GenLSP.Structures.LinkedEditingRangeRegistrationOptions do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The id used to register the request. The id can be used to deregister
    the request again. See also Registration#id.
  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, String.t()
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"id", :id}) => str(),
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schema(), nil]),
      optional({"workDoneProgress", :work_done_progress}) => bool()
    })
  end
end
