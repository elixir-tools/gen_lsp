defmodule GenLSPTest.ExampleServer do
  use GenLSP

  alias GenLSP.Structures.CallHierarchyOptions
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
       capabilities: %Structures.ServerCapabilities{
         call_hierarchy_provider: %CallHierarchyOptions{work_done_progress: true}
       },
       server_info: %{name: "Test LSP"}
     }, lsp}
  end

  def handle_request(%Requests.TextDocumentDocumentSymbol{}, lsp) do
    {:reply, [nil, []], lsp}
  end

  def handle_request(_, lsp) do
    {:reply,
     %GenLSP.ErrorResponse{
       code: GenLSP.Enumerations.ErrorCodes.method_not_found(),
       message: "Method Not Found"
     }, lsp}
  end

  def handle_notification(%Notifications.Initialized{}, lsp) do
    GenLSP.request(lsp, %GenLSP.Requests.ClientRegisterCapability{
      id: System.unique_integer([:positive]),
      params: %GenLSP.Structures.RegistrationParams{
        registrations: [
          %GenLSP.Structures.Registration{
            id: "file-watching",
            method: "workspace/didChangeWatchedFiles",
            register_options: %GenLSP.Structures.DidChangeWatchedFilesRegistrationOptions{
              watchers: [
                %GenLSP.Structures.FileSystemWatcher{
                  glob_pattern: "{lib|test}/**/*.{ex|exs|heex|eex|leex|surface}"
                }
              ]
            }
          }
        ]
      }
    })

    result =
      GenLSP.request(lsp, %GenLSP.Requests.WindowShowMessageRequest{
        id: System.unique_integer([:positive]),
        params: %GenLSP.Structures.ShowMessageRequestParams{
          type: GenLSP.Enumerations.MessageType.error(),
          message:
            "The NextLS runtime failed with errors on dependencies. Would you like to re-fetch them?",
          actions: [
            %GenLSP.Structures.MessageActionItem{title: "yes"},
            %GenLSP.Structures.MessageActionItem{title: "no"}
          ]
        }
      })

    send(lsp.assigns.test_pid, result)

    GenLSP.log(lsp, "done initializing")

    {:noreply, lsp}
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
  def handle_info(:boom, lsp) do
    raise "boom"
    {:noreply, lsp}
  end

  def handle_info(_message, lsp) do
    send(lsp.assigns.test_pid, {:info, :ack})
    {:noreply, lsp}
  end
end
