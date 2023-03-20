# codegen: do not edit
defmodule GenLSP.Enumerations.ErrorCodes do
  @moduledoc """
  Predefined error codes.
  """

  import Schematic, warn: false

  def parse_error, do: -32700

  def invalid_request, do: -32600

  def method_not_found, do: -32601

  def invalid_params, do: -32602

  def internal_error, do: -32603

  @doc """
  Error code indicating that a server received a notification or
  request before the server has received the `initialize` request.
  """
  def server_not_initialized, do: -32002

  def unknown_error_code, do: -32001

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
