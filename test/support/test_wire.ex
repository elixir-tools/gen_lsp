defmodule GenLSPTest.TestWire do
  use GenServer

  # require Logger

  def init, do: :ok

  def start_link(test_pid) do
    GenServer.start_link(__MODULE__, test_pid, name: __MODULE__)
  end

  def init(test_pid) do
    {:ok, %{test_pid: test_pid, messages: [], awaiting: []}}
  end

  def write(body) do
    GenServer.call(__MODULE__, {:write, body})
  end

  def read do
    GenServer.call(__MODULE__, :read)
  end

  def client_write(body) do
    GenServer.call(__MODULE__, {:client_write, body})
  end

  def handle_call({:write, body}, _from, state) do
    # Logger.debug("[TestWire] write")
    send(state.test_pid, {:wire, body})
    {:reply, :ok, state}
  end

  def handle_call(:read, _from, %{messages: [message | rest]} = state) do
    # Logger.debug("[TestWire] read: has messages")
    {:reply, {:ok, message}, %{state | messages: rest}}
  end

  def handle_call(:read, from, %{messages: [], awaiting: awaiting} = state) do
    # Logger.debug("[TestWire] read: no messages")
    {:noreply, %{state | awaiting: [from | awaiting]}}
  end

  def handle_call({:client_write, body}, _from, %{awaiting: [_ | _]} = state) do
    # Logger.debug("[TestWire] client_write: awaiting")

    for pid <- state.awaiting do
      GenServer.reply(pid, {:ok, body})
    end

    {:reply, :ok, state}
  end

  def handle_call({:client_write, body}, _from, %{messages: messages} = state) do
    # Logger.debug("[TestWire] client_write")
    {:reply, :ok, %{state | messages: messages ++ [body]}}
  end
end
