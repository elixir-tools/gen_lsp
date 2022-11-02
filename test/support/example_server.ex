defmodule GenLSPTest.ExampleServer do
  use GenLSP

  alias GenLSP.Protocol.Requests
  alias GenLSP.Protocol.Notifications
  alias GenLSP.Protocol.Structures

  def start_link(opts) do
    {test_pid, opts} = Keyword.pop(opts, :test_pid)
    GenLSP.start_link(__MODULE__, test_pid, opts)
  end

  @impl true
  def init(test_pid) do
    {:ok, %{foo: :bar, test_pid: test_pid}}
  end

  @impl true
  def handle_request(%Requests.Initialize{id: _id}, state) do
    {:reply, %{"capabilities" => %{}, "serverInfo" => %{"name" => "Test LSP"}}, state}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidOpen{} = notification, state) do
    send(state.test_pid, {:callback, notification})

    {:noreply, state}
  end

  def handle_notification(
        %Notifications.TextDocumentDidSave{
          params: %Structures.DidSaveTextDocumentParams{textDocument: textDocument}
        } = notification,
        state
      ) do
    send(state.test_pid, {:callback, notification})

    GenLSP.notify(%Notifications.TextDocumentPublishDiagnostics{
      params: %Structures.PublishDiagnosticsParams{
        uri: textDocument.uri,
        diagnostics: [
          %Structures.Diagnostic{
            range: %Structures.Range{
              start: %Structures.Position{line: 5, character: 12},
              end: %Structures.Position{line: 6, character: 0}
            },
            severity: 1,
            message: "Spelling mistake"
          }
        ]
      }
    })

    {:noreply, state}
  end

  @impl true
  def handle_info(_message, state) do
    send(state.test_pid, {:info, :ack})
    {:noreply, state}
  end
end
