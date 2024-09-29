# codegen: do not edit
defmodule GenLSP.Structures.ShowMessageRequestClientCapabilities do
  @moduledoc """
  Show message request client capabilities
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * message_action_item: Capabilities specific to the `MessageActionItem` type.
  """
  @derive Jason.Encoder
  typedstruct do
    field :message_action_item, map()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"messageActionItem", :message_action_item}) =>
        map(%{
          optional({"additionalPropertiesSupport", :additional_properties_support}) => bool()
        })
    })
  end
end
