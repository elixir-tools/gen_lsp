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
  def init(lsp, test_pid) do
    {:ok, assign(lsp, foo: :bar, test_pid: test_pid)}
  end

  @impl true
  def handle_request(%Requests.Initialize{id: _id}, lsp) do
    {:reply,
     %Structures.InitializeResult{
       capabilities: %Structures.ServerCapabilities{},
       server_info: %{name: "Test LSP"}
     }, lsp}
  end

  @impl true
  def handle_notification(%Notifications.TextDocumentDidOpen{} = notification, lsp) do
    send(lsp.assigns.test_pid, {:callback, notification})

    {:noreply, lsp}
  end

  def handle_notification(
        %Notifications.TextDocumentDidSave{
          params: %Structures.DidSaveTextDocumentParams{text_document: text_document}
        } = notification,
        lsp
      ) do
    send(lsp.assigns.test_pid, {:callback, notification})

    GenLSP.notify(lsp, %Notifications.TextDocumentPublishDiagnostics{
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

    {:noreply, lsp}
  end

  @impl true
  def handle_info(_message, lsp) do
    send(lsp.assigns.test_pid, {:info, :ack})
    {:noreply, lsp}
  end
end
