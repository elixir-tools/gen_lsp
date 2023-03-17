# codegen: do not edit
defmodule GenLSP.Enumerations.DocumentHighlightKind do
  @moduledoc """
  A document highlight kind.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * text: A textual occurrence.
  * read: Read-access of a symbol, like reading a variable.
  * write: Write-access of a symbol, like writing to a variable.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text, GenLSP.BaseTypes.uinteger(), default: 1
    field :read, GenLSP.BaseTypes.uinteger(), default: 2
    field :write, GenLSP.BaseTypes.uinteger(), default: 3
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
