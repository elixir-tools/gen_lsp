# codegen: do not edit
defmodule GenLSP.Structures.WorkDoneProgressCreateParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * token: The token to be used to report progress.
  """
  @derive Jason.Encoder
  typedstruct do
    field :token, GenLSP.TypeAlias.ProgressToken.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"token", :token} => GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
