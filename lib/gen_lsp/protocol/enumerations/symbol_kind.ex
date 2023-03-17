# codegen: do not edit
defmodule GenLSP.Enumerations.SymbolKind do
  @moduledoc """
  A symbol kind.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * file
  * module
  * namespace
  * package
  * class
  * method
  * property
  * field
  * constructor
  * enum
  * interface
  * function
  * variable
  * constant
  * string
  * number
  * boolean
  * array
  * object
  * key
  * null
  * enum_member
  * struct
  * event
  * operator
  * type_parameter
  """
  @derive Jason.Encoder
  typedstruct do
    field :file, GenLSP.BaseTypes.uinteger(), default: 1
    field :module, GenLSP.BaseTypes.uinteger(), default: 2
    field :namespace, GenLSP.BaseTypes.uinteger(), default: 3
    field :package, GenLSP.BaseTypes.uinteger(), default: 4
    field :class, GenLSP.BaseTypes.uinteger(), default: 5
    field :method, GenLSP.BaseTypes.uinteger(), default: 6
    field :property, GenLSP.BaseTypes.uinteger(), default: 7
    field :field, GenLSP.BaseTypes.uinteger(), default: 8
    field :constructor, GenLSP.BaseTypes.uinteger(), default: 9
    field :enum, GenLSP.BaseTypes.uinteger(), default: 10
    field :interface, GenLSP.BaseTypes.uinteger(), default: 11
    field :function, GenLSP.BaseTypes.uinteger(), default: 12
    field :variable, GenLSP.BaseTypes.uinteger(), default: 13
    field :constant, GenLSP.BaseTypes.uinteger(), default: 14
    field :string, GenLSP.BaseTypes.uinteger(), default: 15
    field :number, GenLSP.BaseTypes.uinteger(), default: 16
    field :boolean, GenLSP.BaseTypes.uinteger(), default: 17
    field :array, GenLSP.BaseTypes.uinteger(), default: 18
    field :object, GenLSP.BaseTypes.uinteger(), default: 19
    field :key, GenLSP.BaseTypes.uinteger(), default: 20
    field :null, GenLSP.BaseTypes.uinteger(), default: 21
    field :enum_member, GenLSP.BaseTypes.uinteger(), default: 22
    field :struct, GenLSP.BaseTypes.uinteger(), default: 23
    field :event, GenLSP.BaseTypes.uinteger(), default: 24
    field :operator, GenLSP.BaseTypes.uinteger(), default: 25
    field :type_parameter, GenLSP.BaseTypes.uinteger(), default: 26
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
      int(25),
      int(26)
    ])
  end
end
