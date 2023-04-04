# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceClientCapabilities do
  @moduledoc """
  Workspace specific client capabilities.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * apply_edit: The client supports applying batch edits
    to the workspace by supporting the request
    'workspace/applyEdit'
  * workspace_edit: Capabilities specific to `WorkspaceEdit`s.
  * did_change_configuration: Capabilities specific to the `workspace/didChangeConfiguration` notification.
  * did_change_watched_files: Capabilities specific to the `workspace/didChangeWatchedFiles` notification.
  * symbol: Capabilities specific to the `workspace/symbol` request.
  * execute_command: Capabilities specific to the `workspace/executeCommand` request.
  * workspace_folders: The client has support for workspace folders.

    @since 3.6.0
  * configuration: The client supports `workspace/configuration` requests.

    @since 3.6.0
  * semantic_tokens: Capabilities specific to the semantic token requests scoped to the
    workspace.

    @since 3.16.0.
  * code_lens: Capabilities specific to the code lens requests scoped to the
    workspace.

    @since 3.16.0.
  * file_operations: The client has support for file notifications/requests for user operations on files.

    Since 3.16.0
  * inline_value: Capabilities specific to the inline values requests scoped to the
    workspace.

    @since 3.17.0.
  * inlay_hint: Capabilities specific to the inlay hint requests scoped to the
    workspace.

    @since 3.17.0.
  * diagnostics: Capabilities specific to the diagnostic requests scoped to the
    workspace.

    @since 3.17.0.
  """
  @derive Jason.Encoder
  typedstruct do
    field :apply_edit, boolean()
    field :workspace_edit, GenLSP.Structures.WorkspaceEditClientCapabilities.t()

    field :did_change_configuration,
          GenLSP.Structures.DidChangeConfigurationClientCapabilities.t()

    field :did_change_watched_files, GenLSP.Structures.DidChangeWatchedFilesClientCapabilities.t()
    field :symbol, GenLSP.Structures.WorkspaceSymbolClientCapabilities.t()
    field :execute_command, GenLSP.Structures.ExecuteCommandClientCapabilities.t()
    field :workspace_folders, boolean()
    field :configuration, boolean()
    field :semantic_tokens, GenLSP.Structures.SemanticTokensWorkspaceClientCapabilities.t()
    field :code_lens, GenLSP.Structures.CodeLensWorkspaceClientCapabilities.t()
    field :file_operations, GenLSP.Structures.FileOperationClientCapabilities.t()
    field :inline_value, GenLSP.Structures.InlineValueWorkspaceClientCapabilities.t()
    field :inlay_hint, GenLSP.Structures.InlayHintWorkspaceClientCapabilities.t()
    field :diagnostics, GenLSP.Structures.DiagnosticWorkspaceClientCapabilities.t()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"applyEdit", :apply_edit} => nullable(bool()),
      {"workspaceEdit", :workspace_edit} =>
        nullable(GenLSP.Structures.WorkspaceEditClientCapabilities.schematic()),
      {"didChangeConfiguration", :did_change_configuration} =>
        nullable(GenLSP.Structures.DidChangeConfigurationClientCapabilities.schematic()),
      {"didChangeWatchedFiles", :did_change_watched_files} =>
        nullable(GenLSP.Structures.DidChangeWatchedFilesClientCapabilities.schematic()),
      {"symbol", :symbol} =>
        nullable(GenLSP.Structures.WorkspaceSymbolClientCapabilities.schematic()),
      {"executeCommand", :execute_command} =>
        nullable(GenLSP.Structures.ExecuteCommandClientCapabilities.schematic()),
      {"workspaceFolders", :workspace_folders} => nullable(bool()),
      {"configuration", :configuration} => nullable(bool()),
      {"semanticTokens", :semantic_tokens} =>
        nullable(GenLSP.Structures.SemanticTokensWorkspaceClientCapabilities.schematic()),
      {"codeLens", :code_lens} =>
        nullable(GenLSP.Structures.CodeLensWorkspaceClientCapabilities.schematic()),
      {"fileOperations", :file_operations} =>
        nullable(GenLSP.Structures.FileOperationClientCapabilities.schematic()),
      {"inlineValue", :inline_value} =>
        nullable(GenLSP.Structures.InlineValueWorkspaceClientCapabilities.schematic()),
      {"inlayHint", :inlay_hint} =>
        nullable(GenLSP.Structures.InlayHintWorkspaceClientCapabilities.schematic()),
      {"diagnostics", :diagnostics} =>
        nullable(GenLSP.Structures.DiagnosticWorkspaceClientCapabilities.schematic())
    })
  end
end
