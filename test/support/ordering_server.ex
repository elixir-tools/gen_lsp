defmodule GenLSPTest.OrderingServer do
  use GenLSP
  alias GenLSP.Notifications
  alias GenLSP.Requests
  alias GenLSP.Structures

  def start_link(opts) do
    {test_pid, opts} = Keyword.pop!(opts, :test_pid)
    {order_agent, opts} = Keyword.pop!(opts, :order_agent)
    GenLSP.start_link(__MODULE__, {test_pid, order_agent}, opts)
  end

  @impl true
  def init(lsp, {test_pid, order_agent}) do
    {:ok, assign(lsp, test_pid: test_pid, order_agent: order_agent)}
  end

  @impl true
  def handle_request(%Requests.Initialize{}, lsp) do
    {:reply,
     %Structures.InitializeResult{
       capabilities: %Structures.ServerCapabilities{},
       server_info: %{name: "Ordering Test Server"}
     }, lsp}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidOpen{} = note, lsp) do
    Agent.update(assigns(lsp).order_agent, fn list -> list ++ [:did_open] end)
    send(assigns(lsp).test_pid, {:callback, note})
    {:noreply, lsp}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidChange{} = note, lsp) do
    Agent.update(assigns(lsp).order_agent, fn list -> list ++ [:did_change] end)
    send(assigns(lsp).test_pid, {:callback, note})
    {:noreply, lsp}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidClose{} = note, lsp) do
    Agent.update(assigns(lsp).order_agent, fn list -> list ++ [:did_close] end)
    send(assigns(lsp).test_pid, {:callback, note})
    {:noreply, lsp}
  end
end
