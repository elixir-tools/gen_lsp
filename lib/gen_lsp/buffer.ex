defmodule GenLSP.Buffer do
  @moduledoc """
  The data buffer between the LSP process and the communication channel.
  """
  use GenServer

  require Logger

  @options_schema NimbleOptions.new!(
                    communication: [
                      type: :mod_arg,
                      default: {GenLSP.Communication.Stdio, []},
                      doc:
                        "A `{module, args}` tuple, where `module` implements the `GenLSP.Communication.Adapter` behaviour."
                    ]
                  )

  @doc """
  Starts a `GenLSP.Buffer` process that is linked to the current process.

  ## Options

  #{NimbleOptions.docs(@options_schema)}
  """
  def start_link(opts) do
    opts = NimbleOptions.validate!(opts, @options_schema)
    GenServer.start_link(__MODULE__, opts, name: Keyword.get(opts, :name, __MODULE__))
  end

  @doc false
  def listen(server, lsp) do
    GenServer.cast(server, {:listen, lsp})
  end

  @doc false
  def incoming(server, packet) do
    GenServer.cast(server, {:incoming, packet})
  end

  @doc false
  def outgoing(server, packet, meta) do
    GenServer.cast(server, {:outgoing, packet, meta})
  end

  @doc false
  def comm_state(server) do
    GenServer.call(server, :comm_state)
  end

  @doc false
  def init(opts) do
    {comm, comm_args} = opts[:communication]
    {:ok, comm_data} = comm.init(comm_args)

    {:ok, %{comm: comm, comm_data: comm_data}}
  end

  @doc false
  def handle_call(:comm_state, _from, %{comm_data: comm_data} = state) do
    {:reply, comm_data, state}
  end

  @doc false
  def handle_cast({:incoming, packet}, %{lsp: lsp} = state) do
    default_context = make_ref()
    start_time = System.monotonic_time()

    meta = %{start_time: start_time, context: default_context}

    :telemetry.execute(
      [:gen_lsp, :buffer, :read],
      %{system_time: System.system_time(), monotonic_time: start_time},
      %{telemetry_span_context: default_context}
    )

    case Jason.decode!(packet) do
      %{"id" => _} = request ->
        GenLSP.request_server(lsp, request, meta)

      notification ->
        GenLSP.notify_server(lsp, notification, meta)
    end

    {:noreply, state}
  end

  def handle_cast({:outgoing, packet, meta}, state) do
    data = Jason.encode!(packet)
    stop_time = System.monotonic_time()

    with caller when is_pid(caller) <- packet[:from] do
      dbg "adding caller in outgoing"
      add_caller(caller)
    end

    :telemetry.execute(
      [:gen_lsp, :buffer, :write],
      %{duration: stop_time - meta.start_time, monotonic_time: stop_time},
      %{telemetry_span_context: meta.context, type: meta[:type], method: meta[:method]}
    )

    with caller when is_pid(caller) <- packet[:from] do
      pop_caller(caller)
    end

    :ok = state.comm.write(data, state.comm_data)

    {:noreply, state}
  end

  def handle_cast({:listen, lsp}, state) do
    read(state.comm, state.comm_data)

    {:noreply, Map.put(state, :lsp, lsp)}
  end

  @doc false
  def handle_info({:update_comm_data, comm_data}, state) do
    {:noreply, %{state | comm_data: comm_data}}
  end

  defp read(comm, comm_data) do
    me = self()

    Task.start_link(fn ->
      {:ok, comm_data} = comm.listen(comm_data)
      send(me, {:update_comm_data, comm_data})

      Stream.resource(
        fn -> "" end,
        fn buffer ->
          case comm.read(comm_data, buffer) do
            :eof ->
              {:halt, :ok}

            {:error, reason} ->
              {:halt, {:error, reason}}

            {:ok, body, buffer} ->
              incoming(me, body)

              {[body], buffer}
          end
        end,
        fn
          {:error, reason} ->
            IO.warn("Unable to read from device: #{inspect(reason)}")

          _ ->
            :ok
        end
      )
      |> Enum.to_list()
    end)
  end

  @doc false
  def log(message) do
    Logger.debug(message)
  end

  defp add_caller(caller) do
    callers = Process.get(:"$callers", [])

    # dbg(caller)
    # dbg(callers)

    Process.put(:"$callers", [caller | callers])
  end

  defp pop_caller(caller) do
    callers = Process.get(:"$callers", []) |> List.delete(caller)

    Process.put(:"$callers", callers)
  end
end
