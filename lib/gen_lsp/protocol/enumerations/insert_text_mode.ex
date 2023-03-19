# codegen: do not edit
defmodule GenLSP.Enumerations.InsertTextMode do
  @moduledoc """
  How whitespace and indentation is handled during completion
  item insertion.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * as_is: The insertion or replace strings is taken as it is. If the
    value is multi line the lines below the cursor will be
    inserted using the indentation defined in the string value.
    The client will not apply any kind of adjustments to the
    string.
  * adjust_indentation: The editor adjusts leading whitespace of new lines so that
    they match the indentation up to the cursor of the line for
    which the item is accepted.

    Consider a line like this: <2tabs><cursor><3tabs>foo. Accepting a
    multi line completion item is indented using 2 tabs and all
    following lines inserted will be indented using 2 tabs as well.
  """
  @derive Jason.Encoder
  typedstruct do
    field :as_is, GenLSP.BaseTypes.uinteger(), default: 1
    field :adjust_indentation, GenLSP.BaseTypes.uinteger(), default: 2
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2)
    ])
  end
end
