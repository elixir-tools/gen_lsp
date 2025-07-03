# codegen: do not edit
defmodule GenLSP.Requests do
  import Schematic

  def new(request) do
    unify(
      oneof(fn
        %{"method" => "callHierarchy/incomingCalls"} ->
          GenLSP.Requests.CallHierarchyIncomingCalls.schema()

        %{"method" => "callHierarchy/outgoingCalls"} ->
          GenLSP.Requests.CallHierarchyOutgoingCalls.schema()

        %{"method" => "client/registerCapability"} ->
          GenLSP.Requests.ClientRegisterCapability.schema()

        %{"method" => "client/unregisterCapability"} ->
          GenLSP.Requests.ClientUnregisterCapability.schema()

        %{"method" => "codeAction/resolve"} ->
          GenLSP.Requests.CodeActionResolve.schema()

        %{"method" => "codeLens/resolve"} ->
          GenLSP.Requests.CodeLensResolve.schema()

        %{"method" => "completionItem/resolve"} ->
          GenLSP.Requests.CompletionItemResolve.schema()

        %{"method" => "documentLink/resolve"} ->
          GenLSP.Requests.DocumentLinkResolve.schema()

        %{"method" => "initialize"} ->
          GenLSP.Requests.Initialize.schema()

        %{"method" => "inlayHint/resolve"} ->
          GenLSP.Requests.InlayHintResolve.schema()

        %{"method" => "shutdown"} ->
          GenLSP.Requests.Shutdown.schema()

        %{"method" => "textDocument/codeAction"} ->
          GenLSP.Requests.TextDocumentCodeAction.schema()

        %{"method" => "textDocument/codeLens"} ->
          GenLSP.Requests.TextDocumentCodeLens.schema()

        %{"method" => "textDocument/colorPresentation"} ->
          GenLSP.Requests.TextDocumentColorPresentation.schema()

        %{"method" => "textDocument/completion"} ->
          GenLSP.Requests.TextDocumentCompletion.schema()

        %{"method" => "textDocument/declaration"} ->
          GenLSP.Requests.TextDocumentDeclaration.schema()

        %{"method" => "textDocument/definition"} ->
          GenLSP.Requests.TextDocumentDefinition.schema()

        %{"method" => "textDocument/diagnostic"} ->
          GenLSP.Requests.TextDocumentDiagnostic.schema()

        %{"method" => "textDocument/documentColor"} ->
          GenLSP.Requests.TextDocumentDocumentColor.schema()

        %{"method" => "textDocument/documentHighlight"} ->
          GenLSP.Requests.TextDocumentDocumentHighlight.schema()

        %{"method" => "textDocument/documentLink"} ->
          GenLSP.Requests.TextDocumentDocumentLink.schema()

        %{"method" => "textDocument/documentSymbol"} ->
          GenLSP.Requests.TextDocumentDocumentSymbol.schema()

        %{"method" => "textDocument/foldingRange"} ->
          GenLSP.Requests.TextDocumentFoldingRange.schema()

        %{"method" => "textDocument/formatting"} ->
          GenLSP.Requests.TextDocumentFormatting.schema()

        %{"method" => "textDocument/hover"} ->
          GenLSP.Requests.TextDocumentHover.schema()

        %{"method" => "textDocument/implementation"} ->
          GenLSP.Requests.TextDocumentImplementation.schema()

        %{"method" => "textDocument/inlayHint"} ->
          GenLSP.Requests.TextDocumentInlayHint.schema()

        %{"method" => "textDocument/inlineValue"} ->
          GenLSP.Requests.TextDocumentInlineValue.schema()

        %{"method" => "textDocument/linkedEditingRange"} ->
          GenLSP.Requests.TextDocumentLinkedEditingRange.schema()

        %{"method" => "textDocument/moniker"} ->
          GenLSP.Requests.TextDocumentMoniker.schema()

        %{"method" => "textDocument/onTypeFormatting"} ->
          GenLSP.Requests.TextDocumentOnTypeFormatting.schema()

        %{"method" => "textDocument/prepareCallHierarchy"} ->
          GenLSP.Requests.TextDocumentPrepareCallHierarchy.schema()

        %{"method" => "textDocument/prepareRename"} ->
          GenLSP.Requests.TextDocumentPrepareRename.schema()

        %{"method" => "textDocument/prepareTypeHierarchy"} ->
          GenLSP.Requests.TextDocumentPrepareTypeHierarchy.schema()

        %{"method" => "textDocument/rangeFormatting"} ->
          GenLSP.Requests.TextDocumentRangeFormatting.schema()

        %{"method" => "textDocument/references"} ->
          GenLSP.Requests.TextDocumentReferences.schema()

        %{"method" => "textDocument/rename"} ->
          GenLSP.Requests.TextDocumentRename.schema()

        %{"method" => "textDocument/selectionRange"} ->
          GenLSP.Requests.TextDocumentSelectionRange.schema()

        %{"method" => "textDocument/semanticTokens/full"} ->
          GenLSP.Requests.TextDocumentSemanticTokensFull.schema()

        %{"method" => "textDocument/semanticTokens/full/delta"} ->
          GenLSP.Requests.TextDocumentSemanticTokensFullDelta.schema()

        %{"method" => "textDocument/semanticTokens/range"} ->
          GenLSP.Requests.TextDocumentSemanticTokensRange.schema()

        %{"method" => "textDocument/signatureHelp"} ->
          GenLSP.Requests.TextDocumentSignatureHelp.schema()

        %{"method" => "textDocument/typeDefinition"} ->
          GenLSP.Requests.TextDocumentTypeDefinition.schema()

        %{"method" => "textDocument/willSaveWaitUntil"} ->
          GenLSP.Requests.TextDocumentWillSaveWaitUntil.schema()

        %{"method" => "typeHierarchy/subtypes"} ->
          GenLSP.Requests.TypeHierarchySubtypes.schema()

        %{"method" => "typeHierarchy/supertypes"} ->
          GenLSP.Requests.TypeHierarchySupertypes.schema()

        %{"method" => "window/showDocument"} ->
          GenLSP.Requests.WindowShowDocument.schema()

        %{"method" => "window/showMessageRequest"} ->
          GenLSP.Requests.WindowShowMessageRequest.schema()

        %{"method" => "window/workDoneProgress/create"} ->
          GenLSP.Requests.WindowWorkDoneProgressCreate.schema()

        %{"method" => "workspace/applyEdit"} ->
          GenLSP.Requests.WorkspaceApplyEdit.schema()

        %{"method" => "workspace/codeLens/refresh"} ->
          GenLSP.Requests.WorkspaceCodeLensRefresh.schema()

        %{"method" => "workspace/configuration"} ->
          GenLSP.Requests.WorkspaceConfiguration.schema()

        %{"method" => "workspace/diagnostic"} ->
          GenLSP.Requests.WorkspaceDiagnostic.schema()

        %{"method" => "workspace/diagnostic/refresh"} ->
          GenLSP.Requests.WorkspaceDiagnosticRefresh.schema()

        %{"method" => "workspace/executeCommand"} ->
          GenLSP.Requests.WorkspaceExecuteCommand.schema()

        %{"method" => "workspace/inlayHint/refresh"} ->
          GenLSP.Requests.WorkspaceInlayHintRefresh.schema()

        %{"method" => "workspace/inlineValue/refresh"} ->
          GenLSP.Requests.WorkspaceInlineValueRefresh.schema()

        %{"method" => "workspace/semanticTokens/refresh"} ->
          GenLSP.Requests.WorkspaceSemanticTokensRefresh.schema()

        %{"method" => "workspace/symbol"} ->
          GenLSP.Requests.WorkspaceSymbol.schema()

        %{"method" => "workspace/willCreateFiles"} ->
          GenLSP.Requests.WorkspaceWillCreateFiles.schema()

        %{"method" => "workspace/willDeleteFiles"} ->
          GenLSP.Requests.WorkspaceWillDeleteFiles.schema()

        %{"method" => "workspace/willRenameFiles"} ->
          GenLSP.Requests.WorkspaceWillRenameFiles.schema()

        %{"method" => "workspace/workspaceFolders"} ->
          GenLSP.Requests.WorkspaceWorkspaceFolders.schema()

        %{"method" => "workspaceSymbol/resolve"} ->
          GenLSP.Requests.WorkspaceSymbolResolve.schema()

        _ ->
          {:error, "unexpected request payload"}
      end),
      request
    )
  end
end
