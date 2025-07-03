# codegen: do not edit
defmodule GenLSP.Structures.DiagnosticServerCancellationData do
  @moduledoc """
  Cancellation data returned from a diagnostic request.

  @since 3.17.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * retrigger_request
  """
  @derive Jason.Encoder
  typedstruct do
    field :retrigger_request, boolean(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"retriggerRequest", :retrigger_request} => bool()
    })
  end
end
