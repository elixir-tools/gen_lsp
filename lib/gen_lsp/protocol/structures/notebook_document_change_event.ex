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
      {"metadata", :metadata} => nullable(GenLSP.TypeAlias.LSPObject.schematic()),
      {"cells", :cells} =>
        nullable(
          map(%{
            {"structure", :structure} =>
              nullable(
                map(%{
                  {"array", :array} => GenLSP.Structures.NotebookCellArrayChange.schematic(),
                  {"didOpen", :did_open} =>
                    nullable(list(GenLSP.Structures.TextDocumentItem.schematic())),
                  {"didClose", :did_close} =>
                    nullable(list(GenLSP.Structures.TextDocumentIdentifier.schematic()))
                })
              ),
            {"data", :data} => nullable(list(GenLSP.Structures.NotebookCell.schematic())),
            {"textContent", :text_content} =>
              nullable(
                list(
                  map(%{
                    {"document", :document} =>
                      GenLSP.Structures.VersionedTextDocumentIdentifier.schematic(),
                    {"changes", :changes} =>
                      list(GenLSP.TypeAlias.TextDocumentContentChangeEvent.schematic())
                  })
                )
              )
          })
        )
    })
  end
end
