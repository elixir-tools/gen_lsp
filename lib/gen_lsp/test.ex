defmodule GenLSP.Test do
  import ExUnit.Callbacks
  import ExUnit.Assertions

  @connect_opts [:binary, packet: :raw, active: false]

  @opaque server :: %{
            lsp: pid(),
            buffer: pid()
          }

  @spec server(mod :: atom()) :: server()
  def server(mod) do
    buffer =
      start_supervised!({GenLSP.Buffer, communication: {GenLSP.Communication.TCP, [port: 0]}})

    {:ok, port} = :inet.port(GenLSP.Buffer.comm_state(buffer).lsocket)

    lsp = start_supervised!({mod, [buffer: buffer, test_pid: self()]})

    %{lsp: lsp, buffer: buffer, port: port}
  end

  @opaque client :: %{socket: :gen_tcp.socket()}
  @spec client(server()) :: client()
  def client(server) do
    start_time = System.monotonic_time(:millisecond)

    {:ok, socket} = connect(server.port, start_time)

    me = self()

    Task.start_link(fn ->
      Stream.resource(
        fn -> :ok end,
        fn _acc ->
          case GenLSP.Communication.TCP.read(%{socket: socket}) do
            :eof ->
              {:halt, :ok}

            {:error, reason} ->
              {:halt, {:error, reason}}

            {:ok, body} ->
              send(me, Jason.decode!(body))

              {[body], :ok}
          end
        end,
        fn
          :ok ->
            :ok

          {:error, reason} ->
            IO.warn("Unable to read from device: #{inspect(reason)}")
        end
      )
      |> Enum.to_list()
    end)

    %{socket: socket}
  end

  @spec request(client(), Jason.Encoder.t()) :: {:ok, any()}
  def request(%{socket: socket}, body) do
    GenLSP.Communication.TCP.write(Jason.encode!(body), %{socket: socket})
  end

  @spec notify(client(), Jason.Encoder.t()) :: :ok
  def notify(%{socket: socket}, body) do
    GenLSP.Communication.TCP.write(Jason.encode!(body), %{socket: socket})
  end

  defmacro assert_result(id, pattern, timeout \\ 100) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "id" => unquote(id),
                       "result" => unquote(pattern)
                     },
                     unquote(timeout)
    end
  end

  defmacro assert_notification(method, pattern, timeout \\ 100) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "method" => unquote(method),
                       "params" => unquote(pattern)
                     },
                     unquote(timeout)
    end
  end

  defp connect(port, start_time) do
    now = System.monotonic_time(:millisecond)

    case :gen_tcp.connect('localhost', port, @connect_opts) do
      {:error, :econnrefused} when now - start_time > 5000 ->
        connect(port, start_time)

      other ->
        other
    end
  end
end
