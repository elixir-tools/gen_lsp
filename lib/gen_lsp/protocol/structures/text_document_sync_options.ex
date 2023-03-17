# codegen: do not edit
defmodule GenLSP.Structures.TextDocumentSyncOptions do
  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * open_close: Open and close notifications are sent to the server. If omitted open close notification should not
    be sent.
  * change: Change notifications are sent to the server. See TextDocumentSyncKind.None, TextDocumentSyncKind.Full
    and TextDocumentSyncKind.Incremental. If omitted it defaults to TextDocumentSyncKind.None.
  * will_save: If present will save notifications are sent to the server. If omitted the notification should not be
    sent.
  * will_save_wait_until: If present will save wait until requests are sent to the server. If omitted the request should not be
    sent.
  * save: If present save notifications are sent to the server. If omitted the notification should not be
    sent.
  """
  @derive Jason.Encoder
  typedstruct do
    field :open_close, boolean()
    field :change, GenLSP.Enumerations.TextDocumentSyncKind.t()
    field :will_save, boolean()
    field :will_save_wait_until, boolean()
    field :save, boolean() | GenLSP.Structures.SaveOptions.t()
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"openClose", :open_close} => oneof([null(), bool()]),
      {"change", :change} =>
        oneof([null(), GenLSP.Enumerations.TextDocumentSyncKind.schematic()]),
      {"willSave", :will_save} => oneof([null(), bool()]),
      {"willSaveWaitUntil", :will_save_wait_until} => oneof([null(), bool()]),
      {"save", :save} =>
        oneof([null(), oneof([bool(), GenLSP.Structures.SaveOptions.schematic()])])
    })
  end
end
