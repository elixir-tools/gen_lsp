# codegen: do not edit
defmodule GenLSP.Structures.CreateFilesParams do
  @moduledoc """
  The parameters sent in notifications/requests for user-initiated creation of
  files.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * files: An array of all files/folders created in this operation.
  """
  @derive Jason.Encoder
  typedstruct do
    field :files, list(GenLSP.Structures.FileCreate.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"files", :files} => list(GenLSP.Structures.FileCreate.schema())
    })
  end
end
