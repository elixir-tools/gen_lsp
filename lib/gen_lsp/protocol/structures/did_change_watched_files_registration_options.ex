# codegen: do not edit
defmodule GenLSP.Structures.DidChangeWatchedFilesRegistrationOptions do
  @moduledoc """
  Describe options to be used when registered for text document change events.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * watchers: The watchers to register.
  """
  @derive Jason.Encoder
  typedstruct do
    field :watchers, list(GenLSP.Structures.FileSystemWatcher.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"watchers", :watchers} => list(GenLSP.Structures.FileSystemWatcher.schema())
    })
  end
end
