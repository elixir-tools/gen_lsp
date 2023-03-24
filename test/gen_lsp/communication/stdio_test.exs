defmodule GenLSP.Communication.StdioTest do
  use ExUnit.Case, async: true

  # this includes a char that is 3 bytes in length
  @string ~s|{"a":"‘"}|
  @length byte_size(@string)

  @command "mix run -e '
defmodule GenLSP.Support.Buffer do
  def loop do
    case GenLSP.Communication.Stdio.read([]) do
      :eof ->
        :eof

      {:ok, body} ->
        body
        |> Jason.decode!()
        |> Jason.encode!()
        |> GenLSP.Communication.Stdio.write([])

        loop()
    end
  end
end

GenLSP.Communication.Stdio.init([])

# the following match ensures that the script completes and does
# not raise after stdin is closed.
:eof = GenLSP.Support.Buffer.loop()'"

  test "can read and write through stdio" do
    port = Port.open({:spawn, @command}, [:binary, env: [{'MIX_ENV', 'test'}]])

    expected_message = "Content-Length: #{@length}\r\n\r\n#{@string}"

    # send our message
    assert Port.command(
             port,
             "Whoa: Buddy\nContent-Length: #{@length}\nFoo: Bar\r\n\r\n#{@string}"
           )

    # assert the message is echoed back
    assert_receive {^port, {:data, ^expected_message}}, 2000
  end
end
