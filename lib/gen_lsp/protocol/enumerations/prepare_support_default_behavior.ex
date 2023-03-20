# codegen: do not edit
defmodule GenLSP.Enumerations.PrepareSupportDefaultBehavior do
  import Schematic, warn: false

  @doc """
  The client's default behavior is to select the identifier
  according the to language's syntax rule.
  """
  def identifier, do: 1

  @doc false
  def schematic() do
    oneof([
      int(1)
    ])
  end
end
