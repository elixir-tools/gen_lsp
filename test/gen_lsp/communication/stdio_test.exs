defmodule GenLSP.Communication.StdioTest do
  use ExUnit.Case, async: true

  use ExUnitProperties

  # this includes a char that is 3 bytes in length
  @string ~s|{"a":"‘"}|
  @length byte_size(@string)

  @command "elixir --sname $shortname --cookie monster --erl '-kernel standard_io_encoding latin1' -S mix run -e '
defmodule GenLSP.Support.Buffer do
  def loop(pid) do
    case GenLSP.Communication.Stdio.read([], nil) do
      :eof ->
        System.halt()
        :eof

      {:error, _reason} = error ->
        Process.send(pid, {:buffer, error}, []) 

      {:ok, body, _} ->
        case body |> Jason.decode() do
          {:ok, _} ->
            Process.send(pid, {:buffer, :success}, []) 

          error ->
            Process.send(pid, {:buffer, error, byte_size(body)}, []) 
        end

        loop(pid)
    end
  end
end

defmodule Main do
  def run() do
    true =
      Enum.reduce_while(0..20, false, fn _, _ ->
        if Node.connect(:\"gen_lsp_test@nublar\") do
          Process.sleep(250)
          {:halt, true}
        else
          {:cont, false}
        end
      end)
    pid = \"GENLSPPID\" |> System.get_env() |> Base.decode64!() |> :erlang.binary_to_term()
    GenLSP.Communication.Stdio.init([])

    # the following match ensures that the script completes and does
    # not raise after stdin is closed.
    GenLSP.Support.Buffer.loop(pid)
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
    assert_receive {^port, {:data, ^expected_message}}, 15000
  end

  test "works" do
    {:ok, _} = Node.start(:gen_lsp_test, :shortnames)
    Node.set_cookie(:monster)
    packets = "failed.bin" |> File.read!() |> :erlang.binary_to_term()
    # dbg(packets)

    node = "stdio-test-#{System.system_time()}"

    port =
      Port.open(
        {:spawn, String.replace(@command, "$shortname", node)},
        [
          :binary,
          line: 1024,
          env: [
            {~c"MIX_ENV", ~c"test"},
            {~c"GENLSPPID",
             :erlang.term_to_binary(self()) |> Base.encode64() |> String.to_charlist()}
          ]
        ]
      )

    for packet <- packets do
      packet = Jason.encode!(packet)

      length = byte_size(packet)

      # send our message
      assert Port.command(
               port,
               "Whoa: Buddy\nContent-Length: #{length}\nFoo: Bar\r\n\r\n#{packet}"
             )
    end

    for _packet <- packets do
      # assert the message is echoed back
      assert_receive {:buffer, actual_message}, 10000, "failed to receive output"

      if actual_message != :success do
        # File.write!("failed.bin", :erlang.term_to_binary(packets))
        Node.disconnect(:"#{node}")
        Port.close(port)
        flunk("output was incorrect, received: >>>\n#{inspect(actual_message)}\n<<<")
      end
    end

    Node.disconnect(:"#{node}")
    Port.close(port)
  end

  @tag timeout: :infinity
  property "can read any kind of data through stdio" do
    {:ok, _} = Node.start(:gen_lsp_test, :shortnames)
    Node.set_cookie(:monster)

    simple_term = one_of([boolean(), integer(), string(:utf8)])

    json =
      tree(simple_term, fn leaf ->
        one_of([list_of(leaf), map_of(string(:utf8), leaf)])
      end)

    check all packets <- list_of(json, min_length: 1), max_runs: 1000 do
      node = "stdio-test-#{System.system_time()}"

      port =
        Port.open(
          {:spawn, String.replace(@command, "$shortname", node)},
          [
            :binary,
            line: 1024,
            env: [
              {~c"MIX_ENV", ~c"test"},
              {~c"GENLSPPID",
               :erlang.term_to_binary(self()) |> Base.encode64() |> String.to_charlist()}
            ]
          ]
        )

      for packet <- packets do
        packet = Jason.encode!(packet)

        length = byte_size(packet)

        # send our message
        assert Port.command(
                 port,
                 "Whoa: Buddy\nContent-Length: #{length}\nFoo: Bar\r\n\r\n#{packet}"
               )
      end

      for packet <- packets do
        # assert the message is echoed back
        assert_receive {:buffer, actual_message}, 10000, "failed to receive output"

        if actual_message != :success do
          length = byte_size(packet)
          dbg(length)
          File.write!("failed.bin", :erlang.term_to_binary(packets))
          Node.disconnect(:"#{node}")
          Port.close(port)
          flunk("output was incorrect, received: >>>\n#{inspect(actual_message)}\n<<<")
        end
      end

      Node.disconnect(:"#{node}")
      Port.close(port)
    end
  end
end
