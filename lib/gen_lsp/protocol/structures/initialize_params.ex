# codegen: do not edit
defmodule GenLSP.Structures.InitializeParams do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * process_id: The process Id of the parent process that started
    the server.

    Is `null` if the process has not been started by another process.
    If the parent process is not alive then the server should exit.
  * client_info: Information about the client

    @since 3.15.0
  * locale: The locale the client is currently showing the user interface
    in. This must not necessarily be the locale of the operating
    system.

    Uses IETF language tags as the value's syntax
    (See https://en.wikipedia.org/wiki/IETF_language_tag)

    @since 3.16.0
  * root_path: The rootPath of the workspace. Is null
    if no folder is open.

    @deprecated in favour of rootUri.
  * root_uri: The rootUri of the workspace. Is null if no
    folder is open. If both `rootPath` and `rootUri` are set
    `rootUri` wins.

    @deprecated in favour of workspaceFolders.
  * capabilities: The capabilities provided by the client (editor or tool)
  * initialization_options: User provided initialization options.
  * trace: The initial trace setting. If omitted trace is disabled ('off').
  * workspace_folders: The workspace folders configured in the client when the server starts.

    This property is only available if the client supports workspace folders.
    It can be `null` if the client supports workspace folders but none are
    configured.

    @since 3.6.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :process_id, integer() | nil, enforce: true
    field :client_info, map()
    field :locale, String.t()
    field :root_path, String.t() | nil
    field :root_uri, GenLSP.BaseTypes.document_uri() | nil, enforce: true
    field :capabilities, GenLSP.Structures.ClientCapabilities.t(), enforce: true
    field :initialization_options, GenLSP.TypeAlias.LSPAny.t()
    field :trace, GenLSP.Enumerations.TraceValues.t()
    field :workspace_folders, list(GenLSP.Structures.WorkspaceFolder.t()) | nil
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"processId", :process_id} => oneof([int(), null()]),
      {"clientInfo", :client_info} =>
        oneof([
          null(),
          map(%{
            {"name", :name} => str(),
            {"version", :version} => str()
          })
        ]),
      {"locale", :locale} => oneof([null(), str()]),
      {"rootPath", :root_path} => oneof([null(), oneof([str(), null()])]),
      {"rootUri", :root_uri} => oneof([str(), null()]),
      {"capabilities", :capabilities} => GenLSP.Structures.ClientCapabilities.schematic(),
      {"initializationOptions", :initialization_options} =>
        oneof([null(), GenLSP.TypeAlias.LSPAny.schematic()]),
      {"trace", :trace} => oneof([null(), GenLSP.Enumerations.TraceValues.schematic()]),
      {"workspaceFolders", :workspace_folders} =>
        oneof([null(), oneof([list(GenLSP.Structures.WorkspaceFolder.schematic()), null()])])
    })
  end
end
