# codegen: do not edit
defmodule GenLSP.Structures.InitializeResult do
  @moduledoc """
  The result returned from an initialize request.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Fields

  * capabilities: The capabilities the language server provides.
  * server_info: Information about the server.

    @since 3.15.0
  """
  @derive Jason.Encoder
  typedstruct do
    field :capabilities, GenLSP.Structures.ServerCapabilities.t(), enforce: true
    field :server_info, map()
  end

  @doc false
  @spec schematic() :: Schematic.t()
  def schematic() do
    schema(__MODULE__, %{
      {"capabilities", :capabilities} => GenLSP.Structures.ServerCapabilities.schematic(),
      {"serverInfo", :server_info} =>
        nullable(
          map(%{
            {"name", :name} => str(),
            {"version", :version} => nullable(str())
          })
        )
    })
  end
end
