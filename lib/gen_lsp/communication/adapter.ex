defmodule GenLSP.Communication.Adapter do
  @moduledoc """
  Behaviour for implementing communication adapters for the `GenLSP.Buffer` module to use.

  Existing implementations:

  * `GenLSP.Communication.Stdio`
  * `GenLSP.Communication.TCP`
  """
  @type state :: any()

  @doc """
  Initialize the adapter.

  Here you should return any state that should be passed into the other callbacks.
  """
  @callback init(args :: any()) :: {:ok, state()}
  @doc """
  Read from the client.

  This callback should read a packet of data from the client and return it as the second element in the tuple.

  The third element can be used to return any data that as already been read from the client but still needs to be parsed into a packet.
  """
  @callback read(state(), String.t()) :: {:ok, term(), term()} | :eof | {:error, term()}
  @doc """
  Write data to the client.
  """
  @callback write(body :: String.t(), state()) :: :ok | {:error, term()}

  @doc """
  Tells the adapter to begin listening for data.
  """
  @callback listen(state()) :: {:ok, state()}
end
