# codegen: do not edit
defmodule GenLSP.Structures.ExecuteCommandParams do
  @moduledoc """
  The parameters of a {@link ExecuteCommandRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * command: The identifier of the actual command handler.
  * arguments: Arguments that the command should be invoked with.
  * work_done_token: An optional token that a server can use to report work done progress.
  """
  @derive Jason.Encoder
  typedstruct do
    field :command, String.t(), enforce: true
    field :arguments, list(GenLSP.TypeAlias.LSPAny.t())
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"command", :command} => str(),
      {"arguments", :arguments} => oneof([null(), list(GenLSP.TypeAlias.LSPAny.schematic())]),
      {"workDoneToken", :work_done_token} =>
        oneof([null(), GenLSP.TypeAlias.ProgressToken.schematic()])
    })
  end
end
