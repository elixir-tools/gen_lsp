# codegen: do not edit
defmodule GenLSP.Enumerations.PrepareSupportDefaultBehavior do
  @type t :: 1

  import Schematic, warn: false

  @doc """
  The client's default behavior is to select the identifier
  according the to language's syntax rule.
  """
  @spec identifier() :: 1
  def identifier, do: 1

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      1
    ])
  end
end
