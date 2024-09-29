# codegen: do not edit
defmodule GenLSP.Structures.SemanticTokensDeltaPartialResult do
  @moduledoc """
  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * edits
  """
  @derive Jason.Encoder
  typedstruct do
    field :edits, list(GenLSP.Structures.SemanticTokensEdit.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"edits", :edits} => list(GenLSP.Structures.SemanticTokensEdit.schema())
    })
  end
end
