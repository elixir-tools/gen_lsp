defmodule GenLSP.Communication.Stdio do
  @moduledoc """
  The Standard IO adapter.

  This is the default adapter, and is the communication channel that most LSP clients expect to be able to use.
  """

  @behaviour GenLSP.Communication.Adapter
  @separator "\r\n\r\n"

  @impl true
  def init(_) do
    :ok = :io.setopts(encoding: :latin1, binary: true)

    {:ok, nil}
  end

  @impl true
  def listen(state) do
    {:ok, state}
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
  def read(_, _) do
    headers = read_header(%{})

    case headers do
      :eof ->
        :eof

      {:error, error} ->
        {:error, error}

      headers ->
        body =
          headers
          |> Map.fetch!("Content-Length")
          |> String.to_integer()
          |> read_body()

        {:ok, body, ""}
    end
  end

  defp read_header(headers) do
    case IO.read(:stdio, :line) do
      :eof ->
        :eof

      {:error, error} ->
        {:error, error}

      line ->
        line = String.trim(line)

        case line do
          "" when is_map_key(headers, "Content-Length") ->
            headers

          "" ->
            read_header(headers)

          line ->
            [k, v] = String.split(line, ":", parts: 2)
            read_header(Map.put(headers, String.trim(k), String.trim(v)))
        end
    end
  end

  defp read_body(length) do
    case IO.binread(:stdio, length) do
      :eof ->
        :eof

      {:error, error} ->
        {:error, error}

      payload ->
        payload
    end
  end
end
