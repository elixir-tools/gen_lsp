# codegen: do not edit
defmodule GenLSP.Enumerations.SymbolKind do
  @moduledoc """
  A symbol kind.
  """

  import Schematic, warn: false

  def file, do: 1

  def module, do: 2

  def namespace, do: 3

  def package, do: 4

  def class, do: 5

  def method, do: 6

  def property, do: 7

  def field, do: 8

  def constructor, do: 9

  def enum, do: 10

  def interface, do: 11

  def function, do: 12

  def variable, do: 13

  def constant, do: 14

  def string, do: 15

  def number, do: 16

  def boolean, do: 17

  def array, do: 18

  def object, do: 19

  def key, do: 20

  def null, do: 21

  def enum_member, do: 22

  def struct, do: 23

  def event, do: 24

  def operator, do: 25

  def type_parameter, do: 26

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
