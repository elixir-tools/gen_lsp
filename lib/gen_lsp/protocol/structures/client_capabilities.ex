# codegen: do not edit
defmodule GenLSP.Structures.ClientCapabilities do
  @moduledoc """
  Defines the capabilities provided by the client.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * workspace: Workspace specific client capabilities.
  * text_document: Text document specific client capabilities.
  * notebook_document: Capabilities specific to the notebook document support.

    @since 3.17.0
  * window: Window specific client capabilities.
  * general: General client capabilities.

    @since 3.16.0
  * experimental: Experimental client capabilities.
  """
  @derive Jason.Encoder
  typedstruct do
    field :workspace, GenLSP.Structures.WorkspaceClientCapabilities.t()
    field :text_document, GenLSP.Structures.TextDocumentClientCapabilities.t()
    field :notebook_document, GenLSP.Structures.NotebookDocumentClientCapabilities.t()
    field :window, GenLSP.Structures.WindowClientCapabilities.t()
    field :general, GenLSP.Structures.GeneralClientCapabilities.t()
    field :experimental, GenLSP.TypeAlias.LSPAny.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"workspace", :workspace}) =>
        GenLSP.Structures.WorkspaceClientCapabilities.schema(),
      optional({"textDocument", :text_document}) =>
        GenLSP.Structures.TextDocumentClientCapabilities.schema(),
      optional({"notebookDocument", :notebook_document}) =>
        GenLSP.Structures.NotebookDocumentClientCapabilities.schema(),
      optional({"window", :window}) => GenLSP.Structures.WindowClientCapabilities.schema(),
      optional({"general", :general}) => GenLSP.Structures.GeneralClientCapabilities.schema(),
      optional({"experimental", :experimental}) => GenLSP.TypeAlias.LSPAny.schema()
    })
  end
end
