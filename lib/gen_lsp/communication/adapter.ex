defmodule GenLSP.Communication.Adapter do
  @moduledoc false
  @type state :: any()
  @callback init(args :: any()) :: {:ok, state()}
  @callback read(state(), String.t()) :: {:ok, term(), term()} | :eof | {:error, term()}
  @callback write(body :: String.t(), state()) :: :ok | {:error, term()}
end
