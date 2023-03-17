# codegen: do not edit
defmodule GenLSP.Enumerations.MessageType do
  @moduledoc """
  The message type
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * error: An error message.
  * warning: A warning message.
  * info: An information message.
  * log: A log message.
  """
  @derive Jason.Encoder
  typedstruct do
    field :error, GenLSP.BaseTypes.uinteger(), default: 1
    field :warning, GenLSP.BaseTypes.uinteger(), default: 2
    field :info, GenLSP.BaseTypes.uinteger(), default: 3
    field :log, GenLSP.BaseTypes.uinteger(), default: 4
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
