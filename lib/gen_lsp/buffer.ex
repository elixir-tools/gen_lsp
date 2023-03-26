defmodule GenLSP.Buffer do
  @moduledoc false
  use GenServer

  require Logger

  def start_link(opts) do
    opts = Keyword.validate!(opts, communication: {GenLSP.Communication.Stdio, []})
    GenServer.start_link(__MODULE__, opts, name: Keyword.get(opts, :name, __MODULE__))
  end

  def listen(server, lsp) do
    GenServer.cast(server, {:listen, lsp})
  end

  def incoming(server, packet) do
    GenServer.cast(server, {:incoming, packet})
  end

  def outgoing(server, packet) do
    GenServer.cast(server, {:outgoing, packet})
  end

  @doc false
  def comm_state(server) do
    GenServer.call(server, :comm_state)
  end

  def init(opts) do
    {comm, comm_args} = opts[:communication]
    {:ok, comm_data} = comm.init(comm_args)

    {:ok, %{comm: comm, comm_data: comm_data}}
  end

  def handle_call(:comm_state, _from, %{comm_data: comm_data} = state) do
    {:reply, comm_data, state}
  end

  def handle_cast({:incoming, packet}, %{lsp: lsp} = state) do
    case Jason.decode!(packet) do
      %{"id" => _} = request ->
        GenLSP.request_server(lsp, request)

      notification ->
        GenLSP.notify_server(lsp, notification)
    end

    {:noreply, state}
  end

  def handle_cast({:outgoing, packet}, state) do
    :ok = state.comm.write(Jason.encode!(packet), state.comm_data)

    {:noreply, state}
  end

  def handle_cast({:listen, lsp}, state) do
    read(state.comm, state.comm_data)

    {:noreply, Map.put(state, :lsp, lsp)}
  end

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
          :ok ->
            :ok

          {:error, reason} ->
            IO.warn("Unable to read from device: #{inspect(reason)}")
        end
      )
      |> Enum.to_list()
    end)
  end

  def log(message) do
    Logger.debug(message)
  end
end
