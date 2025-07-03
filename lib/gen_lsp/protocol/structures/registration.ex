# codegen: do not edit
defmodule GenLSP.Structures.Registration do
  @moduledoc """
  General parameters to register for a notification or to register a provider.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The id used to register the request. The id can be used to deregister
    the request again.
  * method: The method / capability to register for.
  * register_options: Options necessary for the registration.
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, String.t(), enforce: true
    field :method, String.t(), enforce: true
    field :register_options, GenLSP.TypeAlias.LSPAny.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"id", :id} => str(),
      {"method", :method} => str(),
      optional({"registerOptions", :register_options}) => GenLSP.TypeAlias.LSPAny.schema()
    })
  end
end
