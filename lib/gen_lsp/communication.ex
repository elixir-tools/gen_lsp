defmodule GenLSP.Communication do
  @moduledoc false

  def init(arg), do: adapter().init(arg)
  def write(body, state), do: adapter().write(body, state)
  def read(state), do: adapter().read(state)
  defp adapter, do: Application.get_env(:gen_lsp, :wire_protocol, GenLSP.Communication.Stdio)
end
