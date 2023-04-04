# codegen: do not edit
defmodule GenLSP.Structures.ExecuteCommandOptions do
  @moduledoc """
  The server capabilities of a {@link ExecuteCommandRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * commands: The commands to be executed on the server
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :commands, list(String.t()), enforce: true
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"commands", :commands} => list(str()),
      {"workDoneProgress", :work_done_progress} => nullable(bool())
    })
  end
end
