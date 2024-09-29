# codegen: do not edit
defmodule GenLSP.Structures.WorkspaceSymbolParams do
  @moduledoc """
  The parameters of a {@link WorkspaceSymbolRequest}.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * query: A query string to filter symbols by. Clients may send an empty
    string here to request all symbols.
  * work_done_token: An optional token that a server can use to report work done progress.
  * partial_result_token: An optional token that a server can use to report partial results (e.g. streaming) to
    the client.
  """
  @derive Jason.Encoder
  typedstruct do
    field :query, String.t(), enforce: true
    field :work_done_token, GenLSP.TypeAlias.ProgressToken.t()
    field :partial_result_token, GenLSP.TypeAlias.ProgressToken.t()
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"query", :query} => str(),
      optional({"workDoneToken", :work_done_token}) => GenLSP.TypeAlias.ProgressToken.schema(),
      optional({"partialResultToken", :partial_result_token}) =>
        GenLSP.TypeAlias.ProgressToken.schema()
    })
  end
end
