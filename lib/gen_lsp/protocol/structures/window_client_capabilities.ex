# codegen: do not edit
defmodule GenLSP.Structures.WindowClientCapabilities do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * work_done_progress: It indicates whether the client supports server initiated
    progress using the `window/workDoneProgress/create` request.
    
    The capability also controls Whether client supports handling
    of progress notifications. If set servers are allowed to report a
    `workDoneProgress` property in the request specific server
    capabilities.
    
    @since 3.15.0
  * show_message: Capabilities specific to the showMessage request.
    
    @since 3.16.0
  * show_document: Capabilities specific to the showDocument request.
    
    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :work_done_progress, boolean()
    field :show_message, GenLSP.Structures.ShowMessageRequestClientCapabilities.t()
    field :show_document, GenLSP.Structures.ShowDocumentClientCapabilities.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"workDoneProgress", :work_done_progress} => oneof([null(), bool()]),
      {"showMessage", :show_message} =>
        oneof([null(), GenLSP.Structures.ShowMessageRequestClientCapabilities.schematic()]),
      {"showDocument", :show_document} =>
        oneof([null(), GenLSP.Structures.ShowDocumentClientCapabilities.schematic()])
    })
  end
end
