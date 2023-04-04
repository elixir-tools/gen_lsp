# codegen: do not edit
defmodule GenLSP.Structures.SemanticTokensOptions do
  @moduledoc """
  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * legend: The legend used by the server
  * range: Server supports providing semantic tokens for a specific range
    of a document.
  * full: Server supports providing semantic tokens for a full document.
  * work_done_progress
  """
  @derive Jason.Encoder
  typedstruct do
    field :legend, GenLSP.Structures.SemanticTokensLegend.t(), enforce: true
    field :range, boolean() | map()
    field :full, boolean() | map()
    field :work_done_progress, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"legend", :legend} => GenLSP.Structures.SemanticTokensLegend.schematic(),
      {"range", :range} => nullable(oneof([bool(), map(%{})])),
      {"full", :full} =>
        nullable(
          oneof([
            bool(),
            map(%{
              {"delta", :delta} => nullable(bool())
            })
          ])
        ),
      {"workDoneProgress", :work_done_progress} => nullable(bool())
    })
  end
end
