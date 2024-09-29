# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceDiagnosticParams do
  @moduledoc """
  Parameters of the workspace diagnostic request.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * identifier: The additional identifier provided during registration.
  * previous_result_ids: The currently known diagnostic reports with their
    previous result ids.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :identifier, String.t()
    field :previous_result_ids, list(GenLSP.Structures.PreviousResultId.t()), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      optional({"identifier", :identifier}) => str(),
      {"previousResultIds", :previous_result_ids} =>
        list(GenLSP.Structures.PreviousResultId.schema()),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      optional({"partialResultToken", :partial_result_token}) =>
        GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
