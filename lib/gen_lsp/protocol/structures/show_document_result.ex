# codegen: do not edit
defmodule GenLSP.Structures.ShowDocumentResult do
  @moduledoc """
  The result of a showDocument request.

  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * success: A boolean indicating if the show was successful.
  """
  @derive Jason.Encoder
  typedstruct do
    field :success, boolean(), enforce: true
  end

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    schema(__MODULE__, %{
      {"success", :success} => bool()
    })
  end
end
