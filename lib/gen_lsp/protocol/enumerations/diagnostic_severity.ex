# codegen: do not edit
defmodule GenLSP.Enumerations.DiagnosticSeverity do
  @moduledoc """
  The diagnostic's severity.
  """

  import Schematic, warn: false

  @doc """
  Reports an error.
  """
  def error, do: 1

  @doc """
  Reports a warning.
  """
  def warning, do: 2

  @doc """
  Reports an information.
  """
  def information, do: 3

  @doc """
  Reports a hint.
  """
  def hint, do: 4

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
