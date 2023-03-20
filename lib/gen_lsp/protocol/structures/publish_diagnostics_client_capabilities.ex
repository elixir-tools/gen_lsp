# codegen: do not edit
defmodule GenLSP.Structures.PublishDiagnosticsClientCapabilities do
  @moduledoc """
  The publish diagnostic client capabilities.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * related_information: Whether the clients accepts diagnostics with related information.
  * tag_support: Client supports the tag property to provide meta data about a diagnostic.
    Clients supporting tags have to handle unknown tags gracefully.

    @since 3.15.0
  * version_support: Whether the client interprets the version property of the
    `textDocument/publishDiagnostics` notification's parameter.

    @since 3.15.0
  * code_description_support: Client supports a codeDescription property

    @since 3.16.0
  * data_support: Whether code action supports the `data` property which is
    preserved between a `textDocument/publishDiagnostics` and
    `textDocument/codeAction` request.

    @since 3.16.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :related_information, boolean()
    field :tag_support, map()
    field :version_support, boolean()
    field :code_description_support, boolean()
    field :data_support, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"relatedInformation", :related_information} => oneof([null(), bool()]),
      {"tagSupport", :tag_support} =>
        oneof([
          null(),
          map(%{
            {"valueSet", :value_set} => list(GenLSP.Enumerations.DiagnosticTag.schematic())
          })
        ]),
      {"versionSupport", :version_support} => oneof([null(), bool()]),
      {"codeDescriptionSupport", :code_description_support} => oneof([null(), bool()]),
      {"dataSupport", :data_support} => oneof([null(), bool()])
    })
  end
end
