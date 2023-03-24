defmodule GenLSP.Support.Buffer do
  def loop(args) do
    case GenLSP.Communication.TCP.read(args) do
      :eof ->
        :eof

      {:ok, body} ->
        body
        |> Jason.decode!()
        |> Jason.encode!()
        |> GenLSP.Communication.TCP.write(args)

        loop(args)
    end
  end
end

defmodule GenLSP.Communication.TCPTest do
  use ExUnit.Case, async: true

  # this includes a char that is 3 bytes in length, that is also very long so that the packet is chunked
  @string ~s|{"a":"‘","b":"#{String.duplicate("hello world! ", 5000)}"}|
  @length byte_size(@string)

  @port 9000

  @connect_opts [:binary, packet: :raw, active: false]

  test "works" do
    me = self()
    # the following match ensures that the script completes and does
    # not raise after stdin is closed.
    Task.start_link(fn ->
      {:ok, args} = GenLSP.Communication.TCP.init(port: @port)
      {:ok, args} = GenLSP.Communication.TCP.listen(args)
      send(me, {:done, args})

      assert :eof = GenLSP.Support.Buffer.loop(args)
    end)

    assert {:ok, socket} = connect()
    expected_message = "Content-Length: #{@length}\r\n\r\n#{@string}"

    assert :ok ==
             :gen_tcp.send(
               socket,
               "Whoa: Buddy\nContent-Length: #{@length}\nFoo: Bar\r\n\r\n#{@string}"
             )

    {:ok, actual} = :gen_tcp.recv(socket, byte_size(expected_message))

    assert expected_message == actual
  end

  defp connect() do
    start_time = System.monotonic_time(:millisecond)

    connect(start_time)
  end

  defp connect(start_time) do
    now = System.monotonic_time(:millisecond)

    case :gen_tcp.connect('localhost', @port, @connect_opts) do
      {:error, :econnrefused} when now - start_time > 5000 ->
        connect(start_time)

      other ->
        other
    end
  end
end
