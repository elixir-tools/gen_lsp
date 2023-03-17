# codegen: do not edit
defmodule GenLSP.Structures.TextDocumentClientCapabilities do
  @moduledoc """
  Text document specific client capabilities.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * synchronization: Defines which synchronization capabilities the client supports.
  * completion: Capabilities specific to the `textDocument/completion` request.
  * hover: Capabilities specific to the `textDocument/hover` request.
  * signature_help: Capabilities specific to the `textDocument/signatureHelp` request.
  * declaration: Capabilities specific to the `textDocument/declaration` request.
    
    @since 3.14.0
  * definition: Capabilities specific to the `textDocument/definition` request.
  * type_definition: Capabilities specific to the `textDocument/typeDefinition` request.
    
    @since 3.6.0
  * implementation: Capabilities specific to the `textDocument/implementation` request.
    
    @since 3.6.0
  * references: Capabilities specific to the `textDocument/references` request.
  * document_highlight: Capabilities specific to the `textDocument/documentHighlight` request.
  * document_symbol: Capabilities specific to the `textDocument/documentSymbol` request.
  * code_action: Capabilities specific to the `textDocument/codeAction` request.
  * code_lens: Capabilities specific to the `textDocument/codeLens` request.
  * document_link: Capabilities specific to the `textDocument/documentLink` request.
  * color_provider: Capabilities specific to the `textDocument/documentColor` and the
    `textDocument/colorPresentation` request.
    
    @since 3.6.0
  * formatting: Capabilities specific to the `textDocument/formatting` request.
  * range_formatting: Capabilities specific to the `textDocument/rangeFormatting` request.
  * on_type_formatting: Capabilities specific to the `textDocument/onTypeFormatting` request.
  * rename: Capabilities specific to the `textDocument/rename` request.
  * folding_range: Capabilities specific to the `textDocument/foldingRange` request.
    
    @since 3.10.0
  * selection_range: Capabilities specific to the `textDocument/selectionRange` request.
    
    @since 3.15.0
  * publish_diagnostics: Capabilities specific to the `textDocument/publishDiagnostics` notification.
  * call_hierarchy: Capabilities specific to the various call hierarchy requests.
    
    @since 3.16.0
  * semantic_tokens: Capabilities specific to the various semantic token request.
    
    @since 3.16.0
  * linked_editing_range: Capabilities specific to the `textDocument/linkedEditingRange` request.
    
    @since 3.16.0
  * moniker: Client capabilities specific to the `textDocument/moniker` request.
    
    @since 3.16.0
  * type_hierarchy: Capabilities specific to the various type hierarchy requests.
    
    @since 3.17.0
  * inline_value: Capabilities specific to the `textDocument/inlineValue` request.
    
    @since 3.17.0
  * inlay_hint: Capabilities specific to the `textDocument/inlayHint` request.
    
    @since 3.17.0
  * diagnostic: Capabilities specific to the diagnostic pull model.
    
    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :synchronization, GenLSP.Structures.TextDocumentSyncClientCapabilities.t()
    field :completion, GenLSP.Structures.CompletionClientCapabilities.t()
    field :hover, GenLSP.Structures.HoverClientCapabilities.t()
    field :signature_help, GenLSP.Structures.SignatureHelpClientCapabilities.t()
    field :declaration, GenLSP.Structures.DeclarationClientCapabilities.t()
    field :definition, GenLSP.Structures.DefinitionClientCapabilities.t()
    field :type_definition, GenLSP.Structures.TypeDefinitionClientCapabilities.t()
    field :implementation, GenLSP.Structures.ImplementationClientCapabilities.t()
    field :references, GenLSP.Structures.ReferenceClientCapabilities.t()
    field :document_highlight, GenLSP.Structures.DocumentHighlightClientCapabilities.t()
    field :document_symbol, GenLSP.Structures.DocumentSymbolClientCapabilities.t()
    field :code_action, GenLSP.Structures.CodeActionClientCapabilities.t()
    field :code_lens, GenLSP.Structures.CodeLensClientCapabilities.t()
    field :document_link, GenLSP.Structures.DocumentLinkClientCapabilities.t()
    field :color_provider, GenLSP.Structures.DocumentColorClientCapabilities.t()
    field :formatting, GenLSP.Structures.DocumentFormattingClientCapabilities.t()
    field :range_formatting, GenLSP.Structures.DocumentRangeFormattingClientCapabilities.t()
    field :on_type_formatting, GenLSP.Structures.DocumentOnTypeFormattingClientCapabilities.t()
    field :rename, GenLSP.Structures.RenameClientCapabilities.t()
    field :folding_range, GenLSP.Structures.FoldingRangeClientCapabilities.t()
    field :selection_range, GenLSP.Structures.SelectionRangeClientCapabilities.t()
    field :publish_diagnostics, GenLSP.Structures.PublishDiagnosticsClientCapabilities.t()
    field :call_hierarchy, GenLSP.Structures.CallHierarchyClientCapabilities.t()
    field :semantic_tokens, GenLSP.Structures.SemanticTokensClientCapabilities.t()
    field :linked_editing_range, GenLSP.Structures.LinkedEditingRangeClientCapabilities.t()
    field :moniker, GenLSP.Structures.MonikerClientCapabilities.t()
    field :type_hierarchy, GenLSP.Structures.TypeHierarchyClientCapabilities.t()
    field :inline_value, GenLSP.Structures.InlineValueClientCapabilities.t()
    field :inlay_hint, GenLSP.Structures.InlayHintClientCapabilities.t()
    field :diagnostic, GenLSP.Structures.DiagnosticClientCapabilities.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"synchronization", :synchronization} =>
        oneof([null(), GenLSP.Structures.TextDocumentSyncClientCapabilities.schematic()]),
      {"completion", :completion} =>
        oneof([null(), GenLSP.Structures.CompletionClientCapabilities.schematic()]),
      {"hover", :hover} => oneof([null(), GenLSP.Structures.HoverClientCapabilities.schematic()]),
      {"signatureHelp", :signature_help} =>
        oneof([null(), GenLSP.Structures.SignatureHelpClientCapabilities.schematic()]),
      {"declaration", :declaration} =>
        oneof([null(), GenLSP.Structures.DeclarationClientCapabilities.schematic()]),
      {"definition", :definition} =>
        oneof([null(), GenLSP.Structures.DefinitionClientCapabilities.schematic()]),
      {"typeDefinition", :type_definition} =>
        oneof([null(), GenLSP.Structures.TypeDefinitionClientCapabilities.schematic()]),
      {"implementation", :implementation} =>
        oneof([null(), GenLSP.Structures.ImplementationClientCapabilities.schematic()]),
      {"references", :references} =>
        oneof([null(), GenLSP.Structures.ReferenceClientCapabilities.schematic()]),
      {"documentHighlight", :document_highlight} =>
        oneof([null(), GenLSP.Structures.DocumentHighlightClientCapabilities.schematic()]),
      {"documentSymbol", :document_symbol} =>
        oneof([null(), GenLSP.Structures.DocumentSymbolClientCapabilities.schematic()]),
      {"codeAction", :code_action} =>
        oneof([null(), GenLSP.Structures.CodeActionClientCapabilities.schematic()]),
      {"codeLens", :code_lens} =>
        oneof([null(), GenLSP.Structures.CodeLensClientCapabilities.schematic()]),
      {"documentLink", :document_link} =>
        oneof([null(), GenLSP.Structures.DocumentLinkClientCapabilities.schematic()]),
      {"colorProvider", :color_provider} =>
        oneof([null(), GenLSP.Structures.DocumentColorClientCapabilities.schematic()]),
      {"formatting", :formatting} =>
        oneof([null(), GenLSP.Structures.DocumentFormattingClientCapabilities.schematic()]),
      {"rangeFormatting", :range_formatting} =>
        oneof([null(), GenLSP.Structures.DocumentRangeFormattingClientCapabilities.schematic()]),
      {"onTypeFormatting", :on_type_formatting} =>
        oneof([null(), GenLSP.Structures.DocumentOnTypeFormattingClientCapabilities.schematic()]),
      {"rename", :rename} =>
        oneof([null(), GenLSP.Structures.RenameClientCapabilities.schematic()]),
      {"foldingRange", :folding_range} =>
        oneof([null(), GenLSP.Structures.FoldingRangeClientCapabilities.schematic()]),
      {"selectionRange", :selection_range} =>
        oneof([null(), GenLSP.Structures.SelectionRangeClientCapabilities.schematic()]),
      {"publishDiagnostics", :publish_diagnostics} =>
        oneof([null(), GenLSP.Structures.PublishDiagnosticsClientCapabilities.schematic()]),
      {"callHierarchy", :call_hierarchy} =>
        oneof([null(), GenLSP.Structures.CallHierarchyClientCapabilities.schematic()]),
      {"semanticTokens", :semantic_tokens} =>
        oneof([null(), GenLSP.Structures.SemanticTokensClientCapabilities.schematic()]),
      {"linkedEditingRange", :linked_editing_range} =>
        oneof([null(), GenLSP.Structures.LinkedEditingRangeClientCapabilities.schematic()]),
      {"moniker", :moniker} =>
        oneof([null(), GenLSP.Structures.MonikerClientCapabilities.schematic()]),
      {"typeHierarchy", :type_hierarchy} =>
        oneof([null(), GenLSP.Structures.TypeHierarchyClientCapabilities.schematic()]),
      {"inlineValue", :inline_value} =>
        oneof([null(), GenLSP.Structures.InlineValueClientCapabilities.schematic()]),
      {"inlayHint", :inlay_hint} =>
        oneof([null(), GenLSP.Structures.InlayHintClientCapabilities.schematic()]),
      {"diagnostic", :diagnostic} =>
        oneof([null(), GenLSP.Structures.DiagnosticClientCapabilities.schematic()])
    })
  end
end
