# codegen: do not edit
defmodule GenLSP.Enumerations.MarkupKind do
  @moduledoc """
  Describes the content type that a client supports in various
  result literals like `Hover`, `ParameterInfo` or `CompletionItem`.

  Please note that `MarkupKinds` must not start with a `$`. This kinds
  are reserved for internal usage.
  """

  import Schematic, warn: false

  @doc """
  Plain text is supported as a content format
  """
  def plain_text, do: "plaintext"

  @doc """
  Markdown is supported as a content format
  """
  def markdown, do: "markdown"

  @doc false
  def schematic() do
    oneof([
      str("plaintext"),
      str("markdown")
    ])
  end
end
