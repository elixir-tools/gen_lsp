# codegen: do not edit
defmodule GenLSP.Notifications do
  import Schematic

  def new(notification) do
    unify(
      oneof(fn
        %{"method" => "$/cancelRequest"} ->
          GenLSP.Notifications.DollarCancelRequest.schema()

        %{"method" => "$/logTrace"} ->
          GenLSP.Notifications.DollarLogTrace.schema()

        %{"method" => "$/progress"} ->
          GenLSP.Notifications.DollarProgress.schema()

        %{"method" => "$/setTrace"} ->
          GenLSP.Notifications.DollarSetTrace.schema()

        %{"method" => "exit"} ->
          GenLSP.Notifications.Exit.schema()

        %{"method" => "initialized"} ->
          GenLSP.Notifications.Initialized.schema()

        %{"method" => "notebookDocument/didChange"} ->
          GenLSP.Notifications.NotebookDocumentDidChange.schema()

        %{"method" => "notebookDocument/didClose"} ->
          GenLSP.Notifications.NotebookDocumentDidClose.schema()

        %{"method" => "notebookDocument/didOpen"} ->
          GenLSP.Notifications.NotebookDocumentDidOpen.schema()

        %{"method" => "notebookDocument/didSave"} ->
          GenLSP.Notifications.NotebookDocumentDidSave.schema()

        %{"method" => "telemetry/event"} ->
          GenLSP.Notifications.TelemetryEvent.schema()

        %{"method" => "textDocument/didChange"} ->
          GenLSP.Notifications.TextDocumentDidChange.schema()

        %{"method" => "textDocument/didClose"} ->
          GenLSP.Notifications.TextDocumentDidClose.schema()

        %{"method" => "textDocument/didOpen"} ->
          GenLSP.Notifications.TextDocumentDidOpen.schema()

        %{"method" => "textDocument/didSave"} ->
          GenLSP.Notifications.TextDocumentDidSave.schema()

        %{"method" => "textDocument/publishDiagnostics"} ->
          GenLSP.Notifications.TextDocumentPublishDiagnostics.schema()

        %{"method" => "textDocument/willSave"} ->
          GenLSP.Notifications.TextDocumentWillSave.schema()

        %{"method" => "window/logMessage"} ->
          GenLSP.Notifications.WindowLogMessage.schema()

        %{"method" => "window/showMessage"} ->
          GenLSP.Notifications.WindowShowMessage.schema()

        %{"method" => "window/workDoneProgress/cancel"} ->
          GenLSP.Notifications.WindowWorkDoneProgressCancel.schema()

        %{"method" => "workspace/didChangeConfiguration"} ->
          GenLSP.Notifications.WorkspaceDidChangeConfiguration.schema()

        %{"method" => "workspace/didChangeWatchedFiles"} ->
          GenLSP.Notifications.WorkspaceDidChangeWatchedFiles.schema()

        %{"method" => "workspace/didChangeWorkspaceFolders"} ->
          GenLSP.Notifications.WorkspaceDidChangeWorkspaceFolders.schema()

        %{"method" => "workspace/didCreateFiles"} ->
          GenLSP.Notifications.WorkspaceDidCreateFiles.schema()

        %{"method" => "workspace/didDeleteFiles"} ->
          GenLSP.Notifications.WorkspaceDidDeleteFiles.schema()

        %{"method" => "workspace/didRenameFiles"} ->
          GenLSP.Notifications.WorkspaceDidRenameFiles.schema()

        _ ->
          {:error, "unexpected notification payload"}
      end),
      notification
    )
  end
end
