defmodule GenLSP.Test do
  @moduledoc """
  Conveniences for testing GenLSP processes.
  """
  import ExUnit.Callbacks
  import ExUnit.Assertions

  @connect_opts [:binary, packet: :raw, active: false]

  @typedoc """
  The test server data structure.
  """
  @opaque server :: %{
            lsp: pid(),
            lsp_id: atom(),
            buffer: pid(),
            buffer_id: atom(),
            assigns: pid(),
            assigns_id: atom(),
            task_supervisor: pid(),
            task_supervisor_id: atom(),
            port: integer()
          }

  @typedoc """
  The test client data structure.
  """
  @opaque client :: %{socket: :gen_tcp.socket(), listener: pid()}

  @doc """
  Starts a new server.

  ## Usage

  ```elixir
  import GenLSP.Test

  server = server(MyLSP, some_arg: some_arg)
  ```
  """
  @spec server(mod :: atom(), opts :: Keyword.t()) :: server()
  def server(mod, opts \\ []) do
    buffer_id = Keyword.get(opts, :buffer_id, :buffer)
    assigns_id = Keyword.get(opts, :assigns_id, :assigns)
    task_supervisor_id = Keyword.get(opts, :task_supervisor_id, :task_supervisor)
    lsp_id = Keyword.get(opts, :lsp_id, :lsp)

    buffer =
      start_supervised!({GenLSP.Buffer, communication: {GenLSP.Communication.TCP, [port: 0]}},
        id: buffer_id
      )

    assigns = start_supervised!(GenLSP.Assigns, id: assigns_id)

    task_supervisor =
      start_supervised!(Supervisor.child_spec(Task.Supervisor, id: task_supervisor_id))

    {:ok, port} = :inet.port(GenLSP.Buffer.comm_state(buffer).lsocket)

    lsp =
      start_supervised!(
        {mod,
         Keyword.merge([buffer: buffer, assigns: assigns, task_supervisor: task_supervisor], opts)},
        id: lsp_id
      )

    %{
      lsp: lsp,
      lsp_id: lsp_id,
      buffer: buffer,
      buffer_id: buffer_id,
      assigns: assigns,
      assigns_id: assigns_id,
      task_supervisor: task_supervisor,
      task_supervisor_id: task_supervisor_id,
      port: port
    }
  end

  @doc """
  Starts a new LSP client for the given server.

  The "client" is equivalent to a text editor.

  ## Usage

  ```elixir
  import GenLSP.Test

  server = server(MyLSP, some_arg: some_arg)
  client = client(server)
  ```
  """
  @spec client(server()) :: client()
  def client(server) do
    start_time = System.monotonic_time(:millisecond)

    {:ok, socket} = connect(server.port, start_time)

    me = self()

    {:ok, listener} =
      Task.start_link(fn ->
        Stream.resource(
          fn -> "" end,
          fn buffer ->
            case GenLSP.Communication.TCP.read(%{socket: socket}, buffer) do
              :eof ->
                {:halt, :ok}

              {:ok, body, buffer} ->
                send(me, Jason.decode!(body))

                {[body], buffer}
            end
          end,
          fn
            :ok ->
              :ok

            {:error, reason} ->
              IO.warn("Unable to read from device: #{inspect(reason)}")

            other ->
              IO.warn(
                "Ended stream with value: #{inspect(other)}. This was probably due to something going wrong."
              )
          end
        )
        |> Enum.to_list()
      end)

    %{socket: socket, listener: listener}
  end

  @doc """
  Shuts down an LSP server.
  """
  @spec shutdown_server!(server :: server()) :: :ok
  def shutdown_server!(server) do
    stop_supervised!(server.buffer_id)
    stop_supervised!(server.assigns_id)
    stop_supervised!(server.task_supervisor_id)
    stop_supervised!(server.lsp_id)

    :ok
  end

  @doc """
  Shuts down an LSP client.
  """
  @spec shutdown_client!(client :: client()) :: :ok
  def shutdown_client!(client) do
    Process.exit(client.listener, :normal)

    :ok
  end

  @doc ~S"""
  Send a request from the client to the server.

  The response from the server will be sent as a message to the current process and can be asserted on using `GenLSP.Test.assert_result/3`.

  ## Usage

  ```elixir
  import GenLSP.Test

  request(client, %{
    method: "initialize",
    id: 1,
    jsonrpc: "2.0",
    params: %{capabilities: %{}, rootUri: "file://#{root_path}"}
  })
  ```
  """
  @spec request(client(), Jason.Encoder.t()) ::
          {:ok, any()} | {:error, :closed | {:timeout, binary()} | :inet.posix()}
  def request(%{socket: socket}, body) do
    GenLSP.Communication.TCP.write(Jason.encode!(body), %{socket: socket})
  end

  @doc """
  Send a notification from the client to the server.

  ## Usage

  ```elixir
  import GenLSP.Test

  notify(client, %{
    method: "initialized",
    jsonrpc: "2.0",
    params: %{}
  })
  ```
  """
  @spec notify(client(), Jason.Encoder.t()) :: :ok
  def notify(%{socket: socket}, body) do
    GenLSP.Communication.TCP.write(Jason.encode!(body), %{socket: socket})
  end

  @doc """
  Simple helper to determine whether the LSP process is alive.
  """
  @spec alive?(server()) :: boolean()
  def alive?(%{lsp: lsp}) do
    Process.alive?(lsp)
  end

  @doc ~S"""
  Assert on the successful response of a request that was sent with `GenLSP.Test.request/2`.

  The second argument is a pattern, similar to `ExUnit.Assertions.assert_receive/3`.

  ## Usage

  ```elixir
  import GenLSP.Test

  id = 1

  request(client, %{
    method: "initialize",
    id: id,
    jsonrpc: "2.0",
    params: %{capabilities: %{}, rootUri: "file://#{root_path}"}
  })

  assert_result(^id, %{
    "capabilities" => %{
      "textDocumentSync" => %{
        "openClose" => true,
        "save" => %{
          "includeText" => true
        },
        "change" => 1
      }
    },
    "serverInfo" => %{"name" => "Credo"}
  })
  ```
  """
  defmacro assert_result(
             id,
             pattern,
             timeout \\ Application.get_env(:ex_unit, :assert_receive_timeout)
           ) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "id" => unquote(id),
                       "result" => unquote(pattern)
                     },
                     unquote(timeout)
    end
  end

  @doc ~S"""
  Assert on the error response of a request that was sent with `GenLSP.Test.request/2`.

  The second argument is a pattern, similar to `ExUnit.Assertions.assert_receive/3`.

  ## Usage

  ```elixir
  import GenLSP.Test

  id = 3

  request(client, %{
    method: "textDocument/documentSymbol",
    id: id,
    jsonrpc: "2.0",
    params: %{
      textDocument: %{
        uri: "file://file/doesnt/matter.ex"
      }
    }
  })

  assert_error(^id, %{
    "code" => -32601,
    "message" => "Method Not Found"
  })
  ```
  """
  defmacro assert_error(
             id,
             pattern,
             timeout \\ Application.get_env(:ex_unit, :assert_receive_timeout)
           ) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "id" => unquote(id),
                       "error" => unquote(pattern)
                     },
                     unquote(timeout)
    end
  end

  @doc ~S"""
  Assert on a notification that was sent from the server.

  The second argument is a pattern, similar to `ExUnit.Assertions.assert_receive/3`.

  ## Usage

  ```elixir
  import GenLSP.Test

  notify(client, %{method: "initialized", jsonrpc: "2.0", params: %{}})

  assert_notification("window/logMessage", %{
    "message" => "[MyLSP] LSP Initialized!",
    "type" => 4
  })
  ```
  """
  defmacro assert_notification(
             method,
             pattern,
             timeout \\ Application.get_env(:ex_unit, :assert_receive_timeout)
           ) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "method" => unquote(method),
                       "params" => unquote(pattern)
                     },
                     unquote(timeout)
    end
  end

  @doc ~S"""
  Assert on a request that was sent from the server.

  ## Usage

  ```elixir
  assert_request(client, "client/registerCapability", 1000, fn params ->
    assert params == %{
             "registrations" => [
               %{
                 "id" => "file-watching",
                 "method" => "workspace/didChangeWatchedFiles",
                 "registerOptions" => %{
                   "watchers" => [
                     %{
                       "globPattern" => "{lib|test}/**/*.{ex|exs|heex|eex|leex|surface}"
                     }
                   ]
                 }
               }
             ]
           }

    nil
  end)
  ```
  """
  defmacro assert_request(
             client,
             method,
             timeout \\ Application.get_env(:ex_unit, :assert_receive_timeout),
             callback
           ) do
    quote do
      assert_receive %{
                       "jsonrpc" => "2.0",
                       "id" => id,
                       "method" => unquote(method),
                       "params" => params
                     },
                     unquote(timeout)

      result = unquote(callback).(params)

      GenLSP.Communication.TCP.write(
        Jason.encode!(%{jsonrpc: "2.0", id: id, result: result}),
        unquote(client)
      )
    end
  end

  defp connect(port, start_time) do
    now = System.monotonic_time(:millisecond)

    case :gen_tcp.connect(~c"localhost", port, @connect_opts) do
      {:error, :econnrefused} when now - start_time > 5000 ->
        connect(port, start_time)

      other ->
        other
    end
  end
end
