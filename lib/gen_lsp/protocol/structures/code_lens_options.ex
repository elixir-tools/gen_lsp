# codegen: do not edit
defmodule GenLSP.Structures.CodeLensOptions do
  @moduledoc """
  Code Lens provider options of a {@link CodeLensRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * resolve_provider: Code lens has a resolve provider as well.
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
