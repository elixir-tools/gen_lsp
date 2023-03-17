# codegen: do not edit
defmodule GenLSP.Enumerations.MarkupKind do
  @moduledoc """
  Describes the content type that a client supports in various
  result literals like `Hover`, `ParameterInfo` or `CompletionItem`.

  Please note that `MarkupKinds` must not start with a `$`. This kinds
  are reserved for internal usage.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * plain_text: Plain text is supported as a content format
  * markdown: Markdown is supported as a content format
  """
  @derive Jason.Encoder
  typedstruct do
    field :plain_text, String.t(), default: "plaintext"
    field :markdown, String.t(), default: "markdown"
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      str("plaintext"),
      str("markdown")
    ])
  end
end
