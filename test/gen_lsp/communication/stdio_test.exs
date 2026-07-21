defmodule GenLSP.Communication.StdioTest do
  use ExUnit.Case, async: true

  # this includes a char that is 3 bytes in length
  @string ~s|{"a":"‘"}|
  @length byte_size(@string)

  @command "elixir --erl '-kernel standard_io_encoding latin1' -S mix run -e '
defmodule GenLSP.Support.Buffer do
  def loop(state) do
    case GenLSP.Communication.Stdio.read(state, nil) do
      :eof ->
        :eof

      {:ok, body, _} ->
        body
        |> Jason.decode!()
        |> Jason.encode!()
        |> GenLSP.Communication.Stdio.write(state)

        loop(state)
    end
  end
end

defmodule Main do
  def run() do
    {:ok, state} = GenLSP.Communication.Stdio.init([])

    # the following match ensures that the script completes and does
    # not raise after stdin is closed.
    :eof = GenLSP.Support.Buffer.loop(state)
  end
end

Main.run()'"

  test "can read and write through stdio" do
    port = Port.open({:spawn, @command}, [:binary, env: [{~c"MIX_ENV", ~c"test"}]])

    expected_message = "Content-Length: #{@length}\r\n\r\n#{@string}"

    # send our message
    assert Port.command(
             port,
             "Whoa: Buddy\nContent-Length: #{@length}\nFoo: Bar\r\n\r\n#{@string}"
           )

    # assert the message is echoed back
    assert_receive {^port, {:data, ^expected_message}}, 2000
  end

  test "reads from and writes to an explicit :device instead of :stdio" do
    {:ok, source} = StringIO.open(~s(Content-Length: 9\r\n\r\n{"a":"b"}))
    {:ok, read_state} = GenLSP.Communication.Stdio.init(device: source)
    assert {:ok, ~s({"a":"b"}), ""} = GenLSP.Communication.Stdio.read(read_state, "")

    {:ok, sink} = StringIO.open("")
    {:ok, write_state} = GenLSP.Communication.Stdio.init(device: sink)
    assert :ok = GenLSP.Communication.Stdio.write(~s({"a":1}), write_state)
    assert {"", ~s(Content-Length: 7\r\n\r\n{"a":1})} = StringIO.contents(sink)
  end

  test "defaults to :stdio when no device is given" do
    assert {:ok, %{device: :stdio}} = GenLSP.Communication.Stdio.init([])
  end
end
