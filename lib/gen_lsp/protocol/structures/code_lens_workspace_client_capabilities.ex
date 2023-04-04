# codegen: do not edit
defmodule GenLSP.Structures.CodeLensWorkspaceClientCapabilities do
  @moduledoc """
  @since 3.16.0
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * refresh_support: Whether the client implementation supports a refresh request sent from the
    server to the client.

    Note that this event is global and will force the client to refresh all
    code lenses currently shown. It should be used with absolute care and is
    useful for situation where a server for example detect a project wide
    change that requires such a calculation.
  """
  @derive Jason.Encoder
  typedstruct do
    field :refresh_support, boolean()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"refreshSupport", :refresh_support} => nullable(bool())
    })
  end
end
