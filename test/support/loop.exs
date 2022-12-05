defmodule GenLSP.Support.Buffer do
  def loop do
    case GenLSP.Communication.Stdio.read() do
      :eof ->
        System.halt(0)
        :eof

      {:ok, body} ->
        Jason.decode!(body)
        loop()
    end
  end
end

GenLSP.Communication.Stdio.init()

GenLSP.Support.Buffer.loop()
