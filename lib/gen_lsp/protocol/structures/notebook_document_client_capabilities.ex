# codegen: do not edit
defmodule GenLSP.Structures.NotebookDocumentClientCapabilities do
  @moduledoc """
  Capabilities specific to the notebook document support.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * synchronization: Capabilities specific to notebook document synchronization

    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :synchronization, GenLSP.Structures.NotebookDocumentSyncClientCapabilities.t(),
      enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"synchronization", :synchronization} =>
        GenLSP.Structures.NotebookDocumentSyncClientCapabilities.schema()
    })
  end
end
