# codegen: do not edit
defmodule GenLSP.Structures.RenameOptions do
  @moduledoc """
  Provider options for a {@link RenameRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * prepare_provider: Renames should be checked and tested before being executed.

    @since version 3.12.0
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :prepare_provider, boolean()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"prepareProvider", :prepare_provider}) => bool(),
      optional({"workDoneProgress", :work_done_progress}) => bool()
    })
  end
end
