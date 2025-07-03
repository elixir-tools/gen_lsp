# codegen: do not edit
defmodule GenLSP.Structures.WorkDoneProgressParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * work_done_token: An optional token that a server can use to report work done progress.
  """
  @derive Jason.Encoder
  typedstruct do
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
