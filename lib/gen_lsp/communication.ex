defmodule GenLSP.Communication.Adapter do
  @moduledoc false
  @callback init() :: :ok
  @callback read() :: {:ok, term()} | :eof | {:error, term()}
  @callback write(String.t()) :: :ok | {:error, term()}
end

defmodule GenLSP.Communication.Stdio do
  require Logger
  @moduledoc false
  @behaviour GenLSP.Communication.Adapter
  @separator "\r\n\r\n"

  @impl true
  def init do
    :ok = :io.setopts(binary: true, encoding: :utf8)
  end

  @impl true
  def write(body) do
    content_length =
      body
      |> IO.iodata_length()
      |> Integer.to_string()

    IO.write(:stdio, ["Content-Length: ", content_length, @separator, body])
  end

  @impl true
  def read do
    headers = read_header(%{})

    case headers do
      :eof ->
        :eof

      headers ->
        body =
          headers
          |> Map.fetch!("Content-Length")
          |> String.to_integer()
          |> read_body()

        {:ok, body}
    end
  end

  defp read_header(headers) do
    case IO.read(:stdio, :line) do
      :eof ->
        :eof

      line ->
        line = String.trim(line)

        case line do
          "" ->
            headers

          line ->
            [k, v] = String.split(line, ":")
            read_header(Map.put(headers, String.trim(k), String.trim(v)))
        end
    end
  end

  defp read_body(length) do
    case IO.read(:stdio, length) do
      :eof ->
        :eof

      payload ->
        :unicode.characters_to_binary(payload)
    end
  end
end

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

  defp adapter, do: Application.get_env(:gen_lsp, :wire_protocol, GenLSP.Communication.Stdio)

  def init, do: adapter().init()
  def write(body), do: adapter().write(body)
  def read, do: adapter().read()
end
