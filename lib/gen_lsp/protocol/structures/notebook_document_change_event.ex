# codegen: do not edit
defmodule GenLSP.Structures.NotebookDocumentChangeEvent do
  @moduledoc """
  A change event for a notebook document.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * metadata: The changed meta data if any.

    Note: should always be an object literal (e.g. LSPObject)
  * cells: Changes to cells
  """
  @derive Jason.Encoder
  typedstruct do
    field :metadata, GenLSP.TypeAlias.LSPObject.t()
    field :cells, map()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"metadata", :metadata}) => GenLSP.TypeAlias.LSPObject.schema(),
      optional({"cells", :cells}) =>
        map(%{
          optional({"structure", :structure}) =>
            map(%{
              {"array", :array} => GenLSP.Structures.NotebookCellArrayChange.schema(),
              optional({"didOpen", :did_open}) =>
                list(GenLSP.Structures.TextDocumentItem.schema()),
              optional({"didClose", :did_close}) =>
                list(GenLSP.Structures.TextDocumentIdentifier.schema())
            }),
          optional({"data", :data}) => list(GenLSP.Structures.NotebookCell.schema()),
          optional({"textContent", :text_content}) =>
            list(
              map(%{
                {"document", :document} =>
                  GenLSP.Structures.VersionedTextDocumentIdentifier.schema(),
                {"changes", :changes} =>
                  list(GenLSP.TypeAlias.TextDocumentContentChangeEvent.schema())
              })
            )
        })
    })
  end
end
