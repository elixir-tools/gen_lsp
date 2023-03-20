# codegen: do not edit
defmodule GenLSP.Structures.NotebookDocumentSyncRegistrationOptions do
  @moduledoc """
  Registration options specific to a notebook.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * id: The id used to register the request. The id can be used to deregister
    the request again. See also Registration#id.
  * notebook_selector: The notebooks to be synced
  * save: Whether save notification should be forwarded to
    the server. Will only be honored if mode === `notebook`.
  """
  @derive Jason.Encoder
  typedstruct do
    field :id, String.t()
    field :notebook_selector, list(map() | map()), enforce: true
    field :save, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"id", :id} => oneof([null(), str()]),
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
