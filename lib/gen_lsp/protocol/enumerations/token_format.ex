# codegen: do not edit
defmodule GenLSP.Enumerations.TokenFormat do
  import Schematic, warn: false

  def relative, do: "relative"

  @doc false
  def schematic() do
    oneof([
      str("relative")
    ])
  end
end
