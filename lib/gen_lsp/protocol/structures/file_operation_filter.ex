# codegen: do not edit
defmodule GenLSP.Structures.FileOperationFilter do
  @moduledoc """
  A filter to describe in which file operation requests or notifications
  the server is interested in receiving.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * scheme: A Uri scheme like `file` or `untitled`.
  * pattern: The actual file operation pattern.
  """
  @derive Jason.Encoder
  typedstruct do
    field :scheme, String.t()
    field :pattern, GenLSP.Structures.FileOperationPattern.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"scheme", :scheme}) => str(),
      {"pattern", :pattern} => GenLSP.Structures.FileOperationPattern.schema()
    })
  end
end
