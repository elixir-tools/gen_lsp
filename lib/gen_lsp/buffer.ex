defmodule GenLSP.Buffer do
  @moduledoc false
  use GenServer

  require Logger

  alias GenLSP.Communication

  def start_link(lsp) do
    GenServer.start_link(__MODULE__, lsp, name: __MODULE__)
  end

  def incoming(packet) do
    GenServer.cast(__MODULE__, {:incoming, packet})
  end

  def outgoing(packet) do
    GenServer.cast(__MODULE__, {:outgoing, packet})
  end

  def init(lsp) when not is_nil(lsp) and (is_atom(lsp) or is_pid(lsp)) do
    {:ok, comm_data} = Communication.init([])
    listen(comm_data)

    {:ok, %{lsp: lsp, comm_data: comm_data}}
  end

  def init(_) do
    {:stop, :lsp_not_provided}
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
    :ok = Communication.write(Jason.encode!(packet), state.comm_data)

    {:noreply, state}
  end

  defp listen(comm_data) do
    Task.start_link(fn ->
      Stream.resource(
        fn -> :ok end,
        fn _acc ->
          case Communication.read(comm_data) do
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
