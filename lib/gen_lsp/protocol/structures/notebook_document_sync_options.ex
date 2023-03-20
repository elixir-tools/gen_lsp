# codegen: do not edit
defmodule GenLSP.Structures.NotebookDocumentSyncOptions do
  @moduledoc """
  Options specific to a notebook plus its cells
  to be synced to the server.

  If a selector provides a notebook document
  filter but no cell selector all cells of a
  matching notebook document will be synced.

  If a selector provides no notebook document
  filter but only a cell selector all notebook
  document that contain at least one matching
  cell will be synced.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * notebook_selector: The notebooks to be synced
  * save: Whether save notification should be forwarded to
    the server. Will only be honored if mode === `notebook`.
  """
  @derive Jason.Encoder
  typedstruct do
    field :notebook_selector, list(map() | map()), enforce: true
    field :save, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"notebookSelector", :notebook_selector} =>
        list(
          oneof([
            map(%{
              {"notebook", :notebook} =>
                oneof([str(), GenLSP.TypeAlias.NotebookDocumentFilter.schematic()]),
              {"cells", :cells} =>
                oneof([
                  null(),
                  list(
                    map(%{
                      {"language", :language} => str()
                    })
                  )
                ])
            }),
            map(%{
              {"notebook", :notebook} =>
                oneof([
                  null(),
                  oneof([str(), GenLSP.TypeAlias.NotebookDocumentFilter.schematic()])
                ]),
              {"cells", :cells} =>
                list(
                  map(%{
                    {"language", :language} => str()
                  })
                )
            })
          ])
        ),
      {"save", :save} => oneof([null(), bool()])
    })
  end
end
