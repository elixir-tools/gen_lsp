# codegen: do not edit
defmodule GenLSP.Enumerations.DiagnosticTag do
  @moduledoc """
  The diagnostic tags.

  @since 3.15.0
  """

  import Schematic, warn: false

  @doc """
  Unused or unnecessary code.

  Clients are allowed to render diagnostics with this tag faded out instead of having
  an error squiggle.
  """
  def unnecessary, do: 1

  @doc """
  Deprecated or obsolete code.

  Clients are allowed to rendered diagnostics with this tag strike through.
  """
  def deprecated, do: 2

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
