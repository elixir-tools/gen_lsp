# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionItemKind do
  @moduledoc """
  The kind of a completion entry.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * text
  * method
  * function
  * constructor
  * field
  * variable
  * class
  * interface
  * module
  * property
  * unit
  * value
  * enum
  * keyword
  * snippet
  * color
  * file
  * reference
  * folder
  * enum_member
  * constant
  * struct
  * event
  * operator
  * type_parameter
  """
  @derive Jason.Encoder
  typedstruct do
    field :text, GenLSP.BaseTypes.uinteger(), default: 1
    field :method, GenLSP.BaseTypes.uinteger(), default: 2
    field :function, GenLSP.BaseTypes.uinteger(), default: 3
    field :constructor, GenLSP.BaseTypes.uinteger(), default: 4
    field :field, GenLSP.BaseTypes.uinteger(), default: 5
    field :variable, GenLSP.BaseTypes.uinteger(), default: 6
    field :class, GenLSP.BaseTypes.uinteger(), default: 7
    field :interface, GenLSP.BaseTypes.uinteger(), default: 8
    field :module, GenLSP.BaseTypes.uinteger(), default: 9
    field :property, GenLSP.BaseTypes.uinteger(), default: 10
    field :unit, GenLSP.BaseTypes.uinteger(), default: 11
    field :value, GenLSP.BaseTypes.uinteger(), default: 12
    field :enum, GenLSP.BaseTypes.uinteger(), default: 13
    field :keyword, GenLSP.BaseTypes.uinteger(), default: 14
    field :snippet, GenLSP.BaseTypes.uinteger(), default: 15
    field :color, GenLSP.BaseTypes.uinteger(), default: 16
    field :file, GenLSP.BaseTypes.uinteger(), default: 17
    field :reference, GenLSP.BaseTypes.uinteger(), default: 18
    field :folder, GenLSP.BaseTypes.uinteger(), default: 19
    field :enum_member, GenLSP.BaseTypes.uinteger(), default: 20
    field :constant, GenLSP.BaseTypes.uinteger(), default: 21
    field :struct, GenLSP.BaseTypes.uinteger(), default: 22
    field :event, GenLSP.BaseTypes.uinteger(), default: 23
    field :operator, GenLSP.BaseTypes.uinteger(), default: 24
    field :type_parameter, GenLSP.BaseTypes.uinteger(), default: 25
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3),
      int(4),
      int(5),
      int(6),
      int(7),
      int(8),
      int(9),
      int(10),
      int(11),
      int(12),
      int(13),
      int(14),
      int(15),
      int(16),
      int(17),
      int(18),
      int(19),
      int(20),
      int(21),
      int(22),
      int(23),
      int(24),
      int(25)
    ])
  end
end
