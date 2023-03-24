# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceSymbolOptions do
  @moduledoc """
  Server capabilities for a {@link WorkspaceSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * resolve_provider: The server provides support to resolve additional
    information for a workspace symbol.

    @since 3.17.0
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :resolve_provider, boolean()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"resolveProvider", :resolve_provider} => oneof([null(), bool()]),
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()])
    })
  end
end
