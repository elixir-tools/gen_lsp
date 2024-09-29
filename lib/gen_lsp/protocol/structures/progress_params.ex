# codegen: do not edit
defmodule GenLSP.Structures.ProgressParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * token: The progress token provided by the client or server.
  * value: The progress data.
  """
  @derive Jason.Encoder
  typedstruct do
    field :token, GenLSP.TypeAlias.ProgressToken.t(), enforce: true
    field :value, GenLSP.TypeAlias.LSPAny.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"token", :token} => GenLSP.TypeAlias.ProgressToken.schema(),
      {"value", :value} => GenLSP.TypeAlias.LSPAny.schema()
    })
  end
end
