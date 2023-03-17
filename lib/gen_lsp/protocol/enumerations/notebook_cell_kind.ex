# codegen: do not edit
defmodule GenLSP.Enumerations.NotebookCellKind do
  @moduledoc """
  A notebook cell kind.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * markup: A markup-cell is formatted source that is used for display.
  * code: A code-cell is source code.
  """
  @derive Jason.Encoder
  typedstruct do
    field :markup, GenLSP.BaseTypes.uinteger(), default: 1
    field :code, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
