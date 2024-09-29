# codegen: do not edit
defmodule GenLSP.Structures.DidChangeWorkspaceFoldersParams do
  @moduledoc """
  The parameters of a `workspace/didChangeWorkspaceFolders` notification.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * event: The actual workspace folder change event.
  """
  @derive Jason.Encoder
  typedstruct do
    field :event, GenLSP.Structures.WorkspaceFoldersChangeEvent.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"event", :event} => GenLSP.Structures.WorkspaceFoldersChangeEvent.schema()
    })
  end
end
