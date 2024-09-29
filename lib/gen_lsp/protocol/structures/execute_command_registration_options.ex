# codegen: do not edit
defmodule GenLSP.Structures.ExecuteCommandRegistrationOptions do
  @moduledoc """
  Registration options for a {@link ExecuteCommandRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * commands: The commands to be executed on the server
  """
  @derive Jason.Encoder
  typedstruct do
    field :commands, list(String.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"commands", :commands} => list(str())
    })
  end
end
