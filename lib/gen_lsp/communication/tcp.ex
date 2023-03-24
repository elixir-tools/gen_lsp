defmodule GenLSP.Communication.TCP do
  @moduledoc false

  @behaviour GenLSP.Communication.Adapter

  @separator "\r\n\r\n"

  @impl true
  def init(args) do
    args = Keyword.validate!(args, port: 6969)

    {:ok, lsocket} =
      :gen_tcp.listen(args[:port], [:binary, packet: :raw, active: false, reuseaddr: true])

    {:ok, %{lsocket: lsocket}}
  end

  def listen(state) do
    {:ok, socket} = :gen_tcp.accept(state.lsocket)
    {:ok, Map.merge(state, %{socket: socket})}
  end

  @impl true
  def write(body, state) do
    content_length =
      body
      |> IO.iodata_length()
      |> Integer.to_string()

    :gen_tcp.send(
      state.socket,
      IO.iodata_to_binary(["Content-Length: ", content_length, @separator, body])
    )
  end

  @impl true
  def read(state) do
    {:ok, packet} = :gen_tcp.recv(state.socket, 0)

    {%{"Content-Length" => length}, buffer} = read_headers(packet)

    body = read_body(state.socket, buffer, String.to_integer(length))

    {:ok, body}
  end

  defp read_body(_socket, buffer, length) when byte_size(buffer) == length do
    buffer
  end

  defp read_body(socket, buffer, length) do
    {:ok, packet} = :gen_tcp.recv(socket, length - byte_size(buffer))

    read_body(socket, buffer <> packet, length)
  end

  defp read_headers(packet) do
    packet
    |> decode_header()
    |> read_headers(Map.new())
  end

  defp read_headers({:ok, :http_eoh, body}, headers) do
    {headers, body}
  end

  defp read_headers({:ok, {:http_header, _, _, header, value}, more}, headers) do
    headers = Map.put(headers, header, value)

    more
    |> decode_header()
    |> read_headers(headers)
  end

  defp decode_header(packet), do: :erlang.decode_packet(:httph_bin, packet, [])
end
