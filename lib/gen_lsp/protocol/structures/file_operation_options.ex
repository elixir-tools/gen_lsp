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
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"didCreate", :did_create}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema(),
      optional({"willCreate", :will_create}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema(),
      optional({"didRename", :did_rename}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema(),
      optional({"willRename", :will_rename}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema(),
      optional({"didDelete", :did_delete}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema(),
      optional({"willDelete", :will_delete}) =>
        GenLSP.Structures.FileOperationRegistrationOptions.schema()
    })
  end
end
