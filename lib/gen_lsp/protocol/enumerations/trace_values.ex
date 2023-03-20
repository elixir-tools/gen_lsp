# codegen: do not edit
defmodule GenLSP.Enumerations.TraceValues do
  import Schematic, warn: false

  @doc """
  Turn tracing off.
  """
  def off, do: "off"

  @doc """
  Trace messages only.
  """
  def messages, do: "messages"

  @doc """
  Verbose message tracing.
  """
  def verbose, do: "verbose"

  @doc false
  def schematic() do
    oneof([
      str("off"),
      str("messages"),
      str("verbose")
    ])
  end
end
