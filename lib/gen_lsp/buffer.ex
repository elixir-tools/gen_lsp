defmodule GenLSP.Buffer do
  @moduledoc false
  use GenServer

  require Logger

  def start_link(opts) do
    opts = Keyword.validate!(opts, [:lsp, communication: {GenLSP.Communication.Stdio, []}])
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def incoming(packet) do
    GenServer.cast(__MODULE__, {:incoming, packet})
  end

  def outgoing(packet) do
    GenServer.cast(__MODULE__, {:outgoing, packet})
  end

  def init(opts) do
    lsp = opts[:lsp]
    {comm, comm_args} = opts[:communication]
    {:ok, comm_data} = comm.init(comm_args)

    listen(comm, comm_data)

    {:ok, %{lsp: lsp, comm: comm, comm_data: comm_data}}
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

  defp listen(comm, comm_data) do
    Task.start_link(fn ->
      Stream.resource(
        fn -> :ok end,
        fn _acc ->
          case comm.read(comm_data) do
            :eof ->
              {:halt, :ok}

            {:error, reason} ->
              {:halt, {:error, reason}}

            {:ok, body} ->
              incoming(body)

              {[body], :ok}
          end
        end,
        fn
          :ok ->
            :ok

          {:error, reason} ->
            IO.warn(:standard_error, "Unable to read from device: #{inspect(reason)}")
        end
      )
      |> Enum.to_list()
    end)
  end

  def log(message) do
    Logger.debug(message)
  end
end
