# codegen: do not edit
defmodule GenLSP.TypeAlias.PrepareRenameResult do
  import Schematic, warn: false

  @type t :: GenLSP.Structures.Range.t() | map() | map()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      GenLSP.Structures.Range.schema(),
      map(%{
        {"range", :range} => GenLSP.Structures.Range.schema(),
        {"placeholder", :placeholder} => str()
      }),
      map(%{
        {"defaultBehavior", :default_behavior} => bool()
      })
    ])
  end
end
