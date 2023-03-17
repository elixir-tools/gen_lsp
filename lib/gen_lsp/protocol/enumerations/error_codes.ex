# codegen: do not edit
defmodule GenLSP.Enumerations.ErrorCodes do
  @moduledoc """
  Predefined error codes.
  """

  import Schematic, warn: false

  use TypedStruct

  @doc """
  ## Values

  * parse_error
  * invalid_request
  * method_not_found
  * invalid_params
  * internal_error
  * server_not_initialized: Error code indicating that a server received a notification or
    request before the server has received the `initialize` request.
  * unknown_error_code
  """
  @derive Jason.Encoder
  typedstruct do
    field :parse_error, integer(), default: -32700
    field :invalid_request, integer(), default: -32600
    field :method_not_found, integer(), default: -32601
    field :invalid_params, integer(), default: -32602
    field :internal_error, integer(), default: -32603
    field :server_not_initialized, integer(), default: -32002
    field :unknown_error_code, integer(), default: -32001
  end

  def v, do: %__MODULE__{}

  @doc false
  def schematic() do
    oneof([
      int(-32700),
      int(-32600),
      int(-32601),
      int(-32602),
      int(-32603),
      int(-32002),
      int(-32001)
    ])
  end
end
