defmodule GenLSP.Log do
  @moduledoc false
  def level(name), do: apply(__MODULE__, name, [])

  def error, do: 1
  def warning, do: 2
  def info, do: 3
  def log, do: 4
end
