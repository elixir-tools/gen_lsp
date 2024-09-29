# codegen: do not edit
defmodule GenLSP.Structures.DidCloseTextDocumentParams do
  @moduledoc """
  The parameters sent in a close text document notification
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * text_document: The document that was closed.
  """
  @derive Jason.Encoder
  typedstruct do
    field :text_document, GenLSP.Structures.TextDocumentIdentifier.t(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"textDocument", :text_document} => GenLSP.Structures.TextDocumentIdentifier.schema()
    })
  end
end
