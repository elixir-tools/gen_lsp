defmodule GenLSP.Communication.Stdio do
  @moduledoc """
  The Standard IO adapter.

  This is the default adapter, and is the communication channel that most LSP clients expect to be able to use.
  """

  @behaviour GenLSP.Communication.Adapter
  @separator "\r\n\r\n"

  @impl true
  @doc """
  ## Options

    * `:device` - the IO device to read from and write to. Defaults to `:stdio`.
  """
  def init(opts) do
    opts = Keyword.validate!(opts, device: :stdio)
    device = opts[:device]

    case device do
      :stdio -> :io.setopts(:standard_io, encoding: :latin1, binary: true)
      _ -> :io.setopts(device, encoding: :latin1, binary: true)
    end

    {:ok, %{device: device}}
  end

  @impl true
  def listen(state) do
    {:ok, state}
  end

  @impl true
  def write(body, %{device: device}) do
    content_length =
      body
      |> IO.iodata_length()
      |> Integer.to_string()

    data = IO.iodata_to_binary(["Content-Length: ", content_length, @separator, body])

    IO.binwrite(device, data)
  end

  @impl true
  def read(%{device: device}, _) do
    headers = read_header(device, %{})

    case headers do
      :eof ->
        :eof

      {:error, error} ->
        {:error, error}

      headers ->
        content_length =
          headers
          |> Map.fetch!("Content-Length")
          |> String.to_integer()

        body = read_body(device, content_length)

        {:ok, body, ""}
    end
  end

  defp read_header(device, headers) do
    case IO.read(device, :line) do
      line when is_binary(line) ->
        line = String.trim(line)

        case line do
          "" when is_map_key(headers, "Content-Length") ->
            headers

          "" ->
            read_header(device, headers)

          line ->
            [k, v] = String.split(line, ":", parts: 2)
            headers = Map.put(headers, String.trim(k), String.trim(v))

            read_header(device, headers)
        end

      :eof ->
        :eof

      {:error, error} ->
        {:error, error}
    end
  end

  defp read_body(device, length) when is_integer(length) do
    case IO.binread(device, length) do
      payload when is_binary(payload) -> payload
      :eof -> :eof
      {:error, error} -> {:error, error}
    end
  end
end
