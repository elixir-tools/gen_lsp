# codegen: do not edit
defmodule GenLSP.Structures.FileEvent do
  @moduledoc """
  An event describing a file change.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * uri: The file's uri.
  * type: The change type.
  """
  @derive Jason.Encoder
  typedstruct do
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :type, GenLSP.Enumerations.FileChangeType.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"uri", :uri} => str(),
      {"type", :type} => GenLSP.Enumerations.FileChangeType.schema()
    })
  end
end
