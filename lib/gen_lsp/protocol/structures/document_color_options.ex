# codegen: do not edit
defmodule GenLSP.Structures.DocumentColorOptions do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"workDoneProgress", :work_done_progress}) => bool()
    })
  end
end
