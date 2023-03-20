defmodule GenLSPTest.ExampleServer do
  use GenLSP

  alias GenLSP.Requests
  alias GenLSP.Notifications
  alias GenLSP.Structures

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
    {:reply,
     %Structures.InitializeResult{capabilities: %Structures.ServerCapabilities{}, server_info: %{"name" => "Test LSP"}}, state}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidOpen{} = notification, state) do
    send(state.test_pid, {:callback, notification})

    {:noreply, state}
  end

  def handle_notification(
        %Notifications.TextDocumentDidSave{
          params: %Structures.DidSaveTextDocumentParams{text_document: text_document}
        } = notification,
        state
      ) do
    send(state.test_pid, {:callback, notification})

    GenLSP.notify(%Notifications.TextDocumentPublishDiagnostics{
      params: %Structures.PublishDiagnosticsParams{
        uri: text_document.uri,
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
