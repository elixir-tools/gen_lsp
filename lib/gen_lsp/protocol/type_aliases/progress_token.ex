# codegen: do not edit
defmodule GenLSP.TypeAlias.ProgressToken do
  import Schematic, warn: false

  @type t :: integer() | String.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([int(), str()])
  end
end
