# codegen: do not edit
defmodule GenLSP.Structures.PublishDiagnosticsParams do
  @moduledoc """
  The publish diagnostic notification's parameters.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * uri: The URI for which diagnostic information is reported.
  * version: Optional the version number of the document the diagnostics are published for.

    @since 3.15.0
  * diagnostics: An array of diagnostic information items.
  """
  @derive Jason.Encoder
  typedstruct do
    field :uri, GenLSP.BaseTypes.document_uri(), enforce: true
    field :version, integer()
    field :diagnostics, list(GenLSP.Structures.Diagnostic.t()), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"uri", :uri} => str(),
      optional({"version", :version}) => int(),
      {"diagnostics", :diagnostics} => list(GenLSP.Structures.Diagnostic.schema())
    })
  end
end
