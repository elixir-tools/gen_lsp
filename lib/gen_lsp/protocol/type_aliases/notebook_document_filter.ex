# codegen: do not edit
defmodule GenLSP.TypeAlias.NotebookDocumentFilter do
  @moduledoc """
  A notebook document filter denotes a notebook document by
  different properties. The properties will be match
  against the notebook's URI (same as with documents)

  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: map() | map() | map()

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    oneof([
      map(%{
        {"notebookType", :notebook_type} => str(),
        {"scheme", :scheme} => nullable(str()),
        {"pattern", :pattern} => nullable(str())
      }),
      map(%{
        {"notebookType", :notebook_type} => nullable(str()),
        {"scheme", :scheme} => str(),
        {"pattern", :pattern} => nullable(str())
      }),
      map(%{
        {"notebookType", :notebook_type} => nullable(str()),
        {"scheme", :scheme} => nullable(str()),
        {"pattern", :pattern} => str()
      })
    ])
  end
end
