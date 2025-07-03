# codegen: do not edit
defmodule GenLSP.Structures.Location do
  @moduledoc """
  Represents a location inside a resource, such as a line
  inside a text file.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * uri
  * range
  """
  @derive Jason.Encoder
  typedstruct do
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :range, GenLSP.Structures.Range.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"uri", :uri} => str(),
      {"range", :range} => GenLSP.Structures.Range.schema()
    })
  end
end
