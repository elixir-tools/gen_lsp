# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceFoldersServerCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * supported: The server has support for workspace folders
  * change_notifications: Whether the server wants to receive workspace folder
    change notifications.

    If a string is provided the string is treated as an ID
    under which the notification is registered on the client
    side. The ID can be used to unregister for these events
    using the `client/unregisterCapability` request.
  """
  @derive Jason.Encoder
  typedstruct do
    field :supported, boolean()
    field :change_notifications, String.t() | boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"supported", :supported} => oneof([null(), bool()]),
      {"changeNotifications", :change_notifications} => oneof([null(), oneof([str(), bool()])])
    })
  end
end
