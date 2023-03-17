# codegen: do not edit
defmodule GenLSP.Structures.ReferenceOptions do
  @moduledoc """
  Reference options.
  """

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
  def schematic() do
    schema(__MODULE__, %{
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()])
    })
  end
end
