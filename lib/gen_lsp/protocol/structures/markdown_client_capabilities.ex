# codegen: do not edit
defmodule GenLSP.Structures.MarkdownClientCapabilities do
  @moduledoc """
  Client capabilities specific to the used markdown parser.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * parser: The name of the parser.
  * version: The version of the parser.
  * allowed_tags: A list of HTML tags that the client allows / supports in
    Markdown.
    
    @since 3.17.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :parser, String.t(), enforce: true
    field :version, String.t()
    field :allowed_tags, list(String.t())
  end

  @doc false
  def schematic() do
    schema(__MODULE__, %{
      {"parser", :parser} => str(),
      {"version", :version} => oneof([null(), str()]),
      {"allowedTags", :allowed_tags} => oneof([null(), list(str())])
    })
  end
end
