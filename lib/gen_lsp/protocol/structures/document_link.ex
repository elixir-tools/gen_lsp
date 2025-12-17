# codegen: do not edit
defmodule GenLSP.Structures.DocumentLink do
  @moduledoc """
  A document link is a range in a text document that links to an internal or external resource, like another
  text document or a web site.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * range: The range this link applies to.
  * target: The uri this link points to. If missing a resolve request is sent later.
  * tooltip: The tooltip text when you hover over this link.

    If a tooltip is provided, is will be displayed in a string that includes instructions on how to
    trigger the link, such as `{0} (ctrl + click)`. The specific instructions vary depending on OS,
    user settings, and localization.

    @since 3.15.0
  * data: A data entry field that is preserved on a document link between a
    DocumentLinkRequest and a DocumentLinkResolveRequest.
  """
  @derive Jason.Encoder
  typedstruct do
    field :range, GenLSP.Structures.Range.t(), enforce: true
    field :target, String.t()
    field :tooltip, String.t()
    field :data, GenLSP.TypeAlias.LSPAny.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"range", :range} => GenLSP.Structures.Range.schema(),
      optional({"target", :target}) => str(),
      optional({"tooltip", :tooltip}) => str(),
      optional({"data", :data}) => GenLSP.TypeAlias.LSPAny.schema()
    })
  end
end
