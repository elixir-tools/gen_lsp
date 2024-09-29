# codegen: do not edit
defmodule GenLSP.Structures.InsertReplaceEdit do
  @moduledoc """
  A special text edit to provide an insert and a replace operation.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * new_text: The string to be inserted.
  * insert: The range if the insert is requested
  * replace: The range if the replace is requested.
  """
  @derive Jason.Encoder
  typedstruct do
    field :new_text, String.t(), enforce: true
    field :insert, GenLSP.Structures.Range.t(), enforce: true
    field :replace, GenLSP.Structures.Range.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"newText", :new_text} => str(),
      {"insert", :insert} => GenLSP.Structures.Range.schema(),
      {"replace", :replace} => GenLSP.Structures.Range.schema()
    })
  end
end
