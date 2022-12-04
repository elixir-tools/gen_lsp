defmodule GenLSP.Communication do
  @moduledoc false

  defmodule LogLevel do
    @moduledoc false
    def level(name), do: apply(__MODULE__, name, [])

    def error, do: 1
    def warning, do: 2
    def info, do: 3
    def log, do: 4
  end

  def init, do: adapter().init()
  def write(body), do: adapter().write(body)
  def read, do: adapter().read()
  defp adapter, do: Application.get_env(:gen_lsp, :wire_protocol, GenLSP.Communication.Stdio)
end
