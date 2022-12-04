defmodule GenLSP.Communication.Adapter do
  @moduledoc false
  @callback init() :: :ok
  @callback read() :: {:ok, term()} | :eof | {:error, term()}
  @callback write(String.t()) :: :ok | {:error, term()}
end
