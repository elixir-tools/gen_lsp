# codegen: do not edit
defmodule GenLSP.Enumerations.CompletionItemKind do
  @moduledoc """
  The kind of a completion entry.
  """

  import Schematic, warn: false

  def text, do: 1

  def method, do: 2

  def function, do: 3

  def constructor, do: 4

  def field, do: 5

  def variable, do: 6

  def class, do: 7

  def interface, do: 8

  def module, do: 9

  def property, do: 10

  def unit, do: 11

  def value, do: 12

  def enum, do: 13

  def keyword, do: 14

  def snippet, do: 15

  def color, do: 16

  def file, do: 17

  def reference, do: 18

  def folder, do: 19

  def enum_member, do: 20

  def constant, do: 21

  def struct, do: 22

  def event, do: 23

  def operator, do: 24

  def type_parameter, do: 25

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
