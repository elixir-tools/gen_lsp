# codegen: do not edit
defmodule GenLSP.Structures.FileSystemWatcher do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * glob_pattern: The glob pattern to watch. See {@link GlobPattern glob pattern} for more detail.

    @since 3.17.0 support for relative patterns.
  * kind: The kind of events of interest. If omitted it defaults
    to WatchKind.Create | WatchKind.Change | WatchKind.Delete
    which is 7.
  """
  @derive Jason.Encoder
  typedstruct do
    field :glob_pattern, GenLSP.TypeAlias.GlobPattern.t(), enforce: true
    field :kind, GenLSP.Enumerations.WatchKind.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"globPattern", :glob_pattern} => GenLSP.TypeAlias.GlobPattern.schema(),
      optional({"kind", :kind}) => GenLSP.Enumerations.WatchKind.schema()
    })
  end
end
