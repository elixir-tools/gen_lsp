# codegen: do not edit
defmodule GenLSP.Structures.FileOperationOptions do
  @moduledoc """
  Options for notifications/requests for user operations on files.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * did_create: The server is interested in receiving didCreateFiles notifications.
  * will_create: The server is interested in receiving willCreateFiles requests.
  * did_rename: The server is interested in receiving didRenameFiles notifications.
  * will_rename: The server is interested in receiving willRenameFiles requests.
  * did_delete: The server is interested in receiving didDeleteFiles file notifications.
  * will_delete: The server is interested in receiving willDeleteFiles file requests.
  """
  @derive Jason.Encoder
  typedstruct do
    field :did_create, GenLSP.Structures.FileOperationRegistrationOptions.t()
    field :will_create, GenLSP.Structures.FileOperationRegistrationOptions.t()
    field :did_rename, GenLSP.Structures.FileOperationRegistrationOptions.t()
    field :will_rename, GenLSP.Structures.FileOperationRegistrationOptions.t()
    field :did_delete, GenLSP.Structures.FileOperationRegistrationOptions.t()
    field :will_delete, GenLSP.Structures.FileOperationRegistrationOptions.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"didCreate", :did_create} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic()),
      {"willCreate", :will_create} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic()),
      {"didRename", :did_rename} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic()),
      {"willRename", :will_rename} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic()),
      {"didDelete", :did_delete} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic()),
      {"willDelete", :will_delete} =>
        nullable(GenLSP.Structures.FileOperationRegistrationOptions.schematic())
    })
  end
end
