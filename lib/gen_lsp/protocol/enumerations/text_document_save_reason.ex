# codegen: do not edit
defmodule GenLSP.Enumerations.TextDocumentSaveReason do
  @moduledoc """
  Represents reasons why a text document is saved.
  """

  import Schematic, warn: false

  @doc """
  Manually triggered, e.g. by the user pressing save, by starting debugging,
  or by an API call.
  """
  def manual, do: 1

  @doc """
  Automatic after a delay.
  """
  def after_delay, do: 2

  @doc """
  When the editor lost focus.
  """
  def focus_out, do: 3

  @doc false
  def schematic() do
    oneof([
      int(1),
      int(2),
      int(3)
    ])
  end
end
