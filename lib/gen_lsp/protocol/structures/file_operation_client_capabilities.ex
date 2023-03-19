# codegen: do not edit
defmodule GenLSP.Structures.FileOperationClientCapabilities do
  @moduledoc """
  Capabilities relating to events from file operations by the user in the client.

  These events do not come from the file system, they come from user operations
  like renaming a file in the UI.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * dynamic_registration: Whether the client supports dynamic registration for file requests/notifications.
  * did_create: The client has support for sending didCreateFiles notifications.
  * will_create: The client has support for sending willCreateFiles requests.
  * did_rename: The client has support for sending didRenameFiles notifications.
  * will_rename: The client has support for sending willRenameFiles requests.
  * did_delete: The client has support for sending didDeleteFiles notifications.
  * will_delete: The client has support for sending willDeleteFiles requests.
  """
  @derive Jason.Encoder
  typedstruct do
    field :dynamic_registration, boolean()
    field :did_create, boolean()
    field :will_create, boolean()
    field :did_rename, boolean()
    field :will_rename, boolean()
    field :did_delete, boolean()
    field :will_delete, boolean()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"dynamicRegistration", :dynamic_registration} => oneof([null(), bool()]),
      {"didCreate", :did_create} => oneof([null(), bool()]),
      {"willCreate", :will_create} => oneof([null(), bool()]),
      {"didRename", :did_rename} => oneof([null(), bool()]),
      {"willRename", :will_rename} => oneof([null(), bool()]),
      {"didDelete", :did_delete} => oneof([null(), bool()]),
      {"willDelete", :will_delete} => oneof([null(), bool()])
    })
  end
end