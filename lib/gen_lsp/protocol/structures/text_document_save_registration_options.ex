# codegen: do not edit
defmodule GenLSP.Structures.TextDocumentSaveRegistrationOptions do
  @moduledoc """
  Save registration options.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * document_selector: A document selector to identify the scope of the registration. If set to null
    the document selector provided on the client side will be used.
  * include_text: The client is supposed to include the content on save.
  """
  @derive Jason.Encoder
  typedstruct do
    field :document_selector, GenLSP.TypeAlias.DocumentSelector.t() | nil, enforce: true
    field :include_text, boolean()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"documentSelector", :document_selector} =>
        oneof([GenLSP.TypeAlias.DocumentSelector.schema(), nil]),
      optional({"includeText", :include_text}) => bool()
    })
  end
end
