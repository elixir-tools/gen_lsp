# codegen: do not edit
defmodule GenLSP.Structures.DocumentLinkOptions do
  @moduledoc """
  Provider options for a {@link DocumentLinkRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * resolve_provider: Document links have a resolve provider as well.
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :resolve_provider, boolean()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"resolveProvider", :resolve_provider}) => bool(),
      optional({"workDoneProgress", :work_done_progress}) => bool()
    })
  end
end
