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
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"metadata", :metadata} => oneof([null(), GenLSP.TypeAlias.LSPObject.schematic()]),
      {"cells", :cells} =>
        oneof([
          null(),
          map(%{
            {"structure", :structure} =>
              oneof([
                null(),
                map(%{
                  {"array", :array} => GenLSP.Structures.NotebookCellArrayChange.schematic(),
                  {"didOpen", :did_open} =>
                    oneof([null(), list(GenLSP.Structures.TextDocumentItem.schematic())]),
                  {"didClose", :did_close} =>
                    oneof([null(), list(GenLSP.Structures.TextDocumentIdentifier.schematic())])
                })
              ]),
            {"data", :data} => oneof([null(), list(GenLSP.Structures.NotebookCell.schematic())]),
            {"textContent", :text_content} =>
              oneof([
                null(),
                list(
                  map(%{
                    {"document", :document} =>
                      GenLSP.Structures.VersionedTextDocumentIdentifier.schematic(),
                    {"changes", :changes} =>
                      list(GenLSP.TypeAlias.TextDocumentContentChangeEvent.schematic())
                  })
                )
              ])
          })
        ])
    })
  end
end
