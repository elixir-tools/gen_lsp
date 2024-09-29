# codegen: do not edit
defmodule GenLSP.Structures.StaticRegistrationOptions do
  @moduledoc """
  Static registration options to be returned in the initialize
  request.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The id used to register the request. The id can be used to deregister
    the request again. See also Registration#id.
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, String.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"id", :id}) => str()
    })
  end
end
