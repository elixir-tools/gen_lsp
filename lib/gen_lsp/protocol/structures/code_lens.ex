# codegen: do not edit
defmodule GenLSP.Structures.CodeLens do
  @moduledoc """
  A code lens represents a {@link Command command} that should be shown along with
  source text, like the number of references, a way to run tests, etc.

  A code lens is _unresolved_ when no command is associated to it. For performance
  reasons the creation of a code lens and resolving should be done in two stages.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The range in which this code lens is valid. Should only span a single line.
  * command: The command this code lens represents.
  * data: A data entry field that is preserved on a code lens item between
    a {@link CodeLensRequest} and a [CodeLensResolveRequest]
    (#CodeLensResolveRequest)
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :command, GenLSP.Structures.Command.t()
    field :data, GenLSP.TypeAlias.LSPAny.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      optional({"command", :command}) => GenLSP.Structures.Command.schema(),
      optional({"data", :data}) => GenLSP.TypeAlias.LSPAny.schema()
    })
  end
end
