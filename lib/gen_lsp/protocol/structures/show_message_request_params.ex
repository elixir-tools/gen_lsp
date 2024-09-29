# codegen: do not edit
defmodule GenLSP.Structures.ShowMessageRequestParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * type: The message type. See {@link MessageType}
  * message: The actual message.
  * actions: The message action items to present.
  """
  @derive Jason.Encoder
  typedstruct do
    field :type, GenLSP.Enumerations.MessageType.t(), enforce: true
    field :message, String.t(), enforce: true
    field :actions, list(GenLSP.Structures.MessageActionItem.t())
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"type", :type} => GenLSP.Enumerations.MessageType.schema(),
      {"message", :message} => str(),
      optional({"actions", :actions}) => list(GenLSP.Structures.MessageActionItem.schema())
    })
  end
end
