# codegen: do not edit
defmodule GenLSP.Structures.PreviousResultId do
  @moduledoc """
  A previous result id in a workspace pull request.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * uri: The URI for which the client knowns a
    result id.
  * value: The value of the previous result id.
  """
  @derive Jason.Encoder
  typedstruct do
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :value, String.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"uri", :uri} => str(),
      {"value", :value} => str()
    })
  end
end
