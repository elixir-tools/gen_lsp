# codegen: do not edit
defmodule GenLSP.Structures.DocumentSymbolOptions do
  @moduledoc """
  Provider options for a {@link DocumentSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * label: A human-readable string that is shown when multiple outlines trees
    are shown for the same document.

    @since 3.16.0
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :label, String.t()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"label", :label} => oneof([null(), str()]),
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()])
    })
  end
end
