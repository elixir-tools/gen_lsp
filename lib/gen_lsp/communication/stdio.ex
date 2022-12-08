defmodule GenLSP.Communication.Stdio do
  @moduledoc false

  require Logger

  @behaviour GenLSP.Communication.Adapter
  @separator "\r\n\r\n"

  @impl true
  def init(_) do
    :ok = :io.setopts(encoding: :latin1, binary: true)

    {:ok, nil}
  end

  @impl true
  def write(body, _) do
    content_length =
      body
      |> IO.iodata_length()
      |> Integer.to_string()

    IO.binwrite(
      :stdio,
      IO.iodata_to_binary(["Content-Length: ", content_length, @separator, body])
    )
  end

  @impl true
  def read(_) do
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
          "" when is_map_key(headers, "Content-Length") ->
            headers

          "" ->
            read_header(headers)

          line ->
            [k, v] = String.split(line, ":")
            read_header(Map.put(headers, String.trim(k), String.trim(v)))
        end
    end
  end

  defp read_body(length) do
    case IO.binread(:stdio, length) do
      :eof ->
        :eof

      payload ->
        payload
    end
  end
end
