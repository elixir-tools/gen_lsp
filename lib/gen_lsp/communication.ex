defmodule GenLSP.Communication do
  @moduledoc false

  def init, do: adapter().init()
  def write(body), do: adapter().write(body)
  def read, do: adapter().read()
  defp adapter, do: Application.get_env(:gen_lsp, :wire_protocol, GenLSP.Communication.Stdio)
end
