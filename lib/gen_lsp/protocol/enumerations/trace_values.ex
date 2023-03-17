# codegen: do not edit
defmodule GenLSP.Enumerations.TraceValues do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * off: Turn tracing off.
  * messages: Trace messages only.
  * verbose: Verbose message tracing.
  """
  @derive Jason.Encoder
  typedstruct do
    field :off, String.t(), default: "off"
    field :messages, String.t(), default: "messages"
    field :verbose, String.t(), default: "verbose"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("off"),
      str("messages"),
      str("verbose")
    ])
  end
end
