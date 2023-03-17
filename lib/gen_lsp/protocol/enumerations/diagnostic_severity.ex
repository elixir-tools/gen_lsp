# codegen: do not edit
defmodule GenLSP.Enumerations.DiagnosticSeverity do
  @moduledoc """
  The diagnostic's severity.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * error: Reports an error.
  * warning: Reports a warning.
  * information: Reports an information.
  * hint: Reports a hint.
  """
  @derive Jason.Encoder
  typedstruct do
    field :error, GenLSP.BaseTypes.uinteger(), default: 1
    field :warning, GenLSP.BaseTypes.uinteger(), default: 2
    field :information, GenLSP.BaseTypes.uinteger(), default: 3
    field :hint, GenLSP.BaseTypes.uinteger(), default: 4
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3),
      int(4)
    ])
  end
end
