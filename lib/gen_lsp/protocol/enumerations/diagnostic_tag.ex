# codegen: do not edit
defmodule GenLSP.Enumerations.DiagnosticTag do
  @moduledoc """
  The diagnostic tags.

  @since 3.15.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * unnecessary: Unused or unnecessary code.

    Clients are allowed to render diagnostics with this tag faded out instead of having
    an error squiggle.
  * deprecated: Deprecated or obsolete code.

    Clients are allowed to rendered diagnostics with this tag strike through.
  """
  @derive Jason.Encoder
  typedstruct do
    field :unnecessary, GenLSP.BaseTypes.uinteger(), default: 1
    field :deprecated, GenLSP.BaseTypes.uinteger(), default: 2
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
