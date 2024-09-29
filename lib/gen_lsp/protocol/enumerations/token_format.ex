# codegen: do not edit
defmodule GenLSP.Enumerations.TokenFormat do
  @type t :: String.t()

  import Schematic, warn: false

  @spec relative() :: String.t()
  def relative, do: "relative"

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      "relative"
    ])
  end
end
