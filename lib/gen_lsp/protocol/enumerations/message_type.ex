# codegen: do not edit
defmodule GenLSP.Enumerations.MessageType do
  @moduledoc """
  The message type
  """

  import Schematic, warn: false

  @doc """
  An error message.
  """
  def error, do: 1

  @doc """
  A warning message.
  """
  def warning, do: 2

  @doc """
  An information message.
  """
  def info, do: 3

  @doc """
  A log message.
  """
  def log, do: 4

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
