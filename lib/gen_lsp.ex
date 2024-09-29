defmodule GenLSP do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  defmodule InvalidRequest do
    defexception message: nil

    @impl true
    def exception({request, errors}) do
      msg = """
      Invalid request from the client

      Received: #{inspect(request)}
      Errors: #{inspect(errors)}
      """

      %__MODULE__{message: msg}
    end
  end

  defmodule InvalidResponse do
    defexception message: nil

    @impl true
    def exception({method, response, errors}) do
      msg = """
      Invalid response for request #{method}.

      Response: #{inspect(response)}
      Errors: #{inspect(errors)}
      """

      %__MODULE__{message: msg}
    end
  end

  defmodule InvalidNotification do
    defexception message: nil

    @impl true
    def exception({notification, errors}) do
      msg = """
      Invalid notification from the client

      Given: #{inspect(notification)}
      Errors: #{inspect(errors)}
      """

      %__MODULE__{message: msg}
    end
  end

  alias GenLSP.LSP

  defmacro __using__(_) do
    quote do
      @behaviour GenLSP

      require Logger

      import GenLSP.LSP

      def child_spec(opts) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [opts]},
          type: :worker,
          restart: :permanent,
          shutdown: 500
        }
      end

      @impl true
      def handle_info(_, state) do
        Logger.warning("Unhandled message passed to handle_info/2")

        {:noreply, state}
      end

      defoverridable handle_info: 2
    end
  end

  require Logger

  @doc """
  The callback responsible for initializing the process.

  Receives the `t:GenLSP.LSP.t/0` token as the first argument and the arguments that were passed to `GenLSP.start_link/3` as the second.

  ## Usage

  ```elixir
  @impl true
  def init(lsp, args) do
    some_arg = Keyword.fetch!(args, :some_arg)

    {:ok, assign(lsp, static_assign: :some_assign, some_arg: some_arg)}
  end
  ```
  """
  @callback init(lsp :: GenLSP.LSP.t(), init_arg :: term()) :: {:ok, GenLSP.LSP.t()}
  @doc """
  The callback responsible for handling requests from the client.

  Receives the request struct as the first argument and the LSP token `t:GenLSP.LSP.t/0` as the second.

  ## Usage

  ```elixir
  @impl true
  def handle_request(%Initialize{params: %InitializeParams{root_uri: root_uri}}, lsp) do
    {:reply,
     %InitializeResult{
       capabilities: %ServerCapabilities{
         text_document_sync: %TextDocumentSyncOptions{
           open_close: true,
           save: %SaveOptions{include_text: true},
           change: TextDocumentSyncKind.full()
         }
       },
       server_info: %{name: "MyLSP"}
     }, assign(lsp, root_uri: root_uri)}
  end
  ```
  """
  @callback handle_request(request :: term(), state) ::
              {:reply, reply :: term(), state} | {:noreply, state}
            when state: GenLSP.LSP.t()
  @doc """
  The callback responsible for handling notifications from the client.

  Receives the notification struct as the first argument and the LSP token `t:GenLSP.LSP.t/0` as the second.

  ## Usage

  ```elixir
  @impl true
  def handle_notification(%Initialized{}, lsp) do
    # handle the notification

    {:noreply, lsp}
  end
  ```
  """
  @callback handle_notification(notification :: term(), state) :: {:noreply, state}
            when state: GenLSP.LSP.t()
  @doc """
  The callback responsible for handling normal messages.

  Receives the message as the first argument and the LSP token `t:GenLSP.LSP.t/0` as the second.

  ## Usage

  ```elixir
  @impl true
  def handle_info(message, lsp) do
    # handle the message

    {:noreply, lsp}
  end
  ```
  """
  @callback handle_info(message :: any(), state) :: {:noreply, state} when state: GenLSP.LSP.t()

  @options_schema NimbleOptions.new!(
                    buffer: [
                      type: {:or, [:pid, :atom]},
                      doc: "The `t:pid/0` or name of the `GenLSP.Buffer` process."
                    ],
                    name: [
                      type: :atom,
                      doc:
                        "Used for name registration as described in the \"Name registration\" section in the documentation for `GenServer`."
                    ]
                  )

  @doc """
  Starts a `GenLSP` process that is linked to the current process.

  ## Options

  #{NimbleOptions.docs(@options_schema)}
  """
  def start_link(module, init_args, opts) do
    opts = NimbleOptions.validate!(opts, @options_schema)

    :proc_lib.start_link(__MODULE__, :init, [
      {module, init_args, Keyword.take(opts, [:name, :buffer]), self()}
    ])
  end

  @doc false
  def init({module, init_args, opts, parent}) do
    me = self()
    buffer = opts[:buffer]
    lsp = %LSP{mod: module, pid: me, buffer: buffer}

    case module.init(lsp, init_args) do
      {:ok, %LSP{} = lsp} ->
        deb = :sys.debug_options([])
        if opts[:name], do: Process.register(self(), opts[:name])
        :proc_lib.init_ack(parent, {:ok, me})

        GenLSP.Buffer.listen(buffer, me)

        loop(lsp, parent, deb)
    end
  end

  @doc """
  Sends a request from the client to the LSP process.

  Generally used by the `GenLSP.Communication.Adapter` implementation to forward messages from the buffer to the LSP process.

  You shouldn't need to use this to implement a language server.
  """
  @spec request_server(pid(), message) :: message when message: term()
  def request_server(pid, request) do
    from = self()
    message = {:request, from, request}
    send(pid, message)
  end

  @doc """
  Sends a notification from the client to the LSP process.

  Generally used by the `GenLSP.Communication.Adapter` implementation to forward messages from the buffer to the LSP process.

  You shouldn't need to use this to implement a language server.
  """
  @spec notify_server(pid(), message) :: message when message: term()
  def notify_server(pid, notification) do
    from = self()
    send(pid, {:notification, from, notification})
  end

  @doc ~S'''
  Sends a notification to the client from the LSP process.

  ## Usage

  ```elixir
  GenLSP.notify(lsp, %TextDocumentPublishDiagnostics{
    params: %PublishDiagnosticsParams{
      uri: "file://#{file}",
      diagnostics: diagnostics
    }
  })
  ```
  '''
  @spec notify(GenLSP.LSP.t(), notification :: any()) :: :ok
  def notify(%{buffer: buffer}, notification) do
    Logger.debug("sent notification server -> client #{notification.method}",
      method: notification.method
    )

    :telemetry.span([:gen_lsp, :notify, :server], %{}, fn ->
      result =
        GenLSP.Buffer.outgoing(buffer, dump!(notification.__struct__.schema(), notification))

      {result, %{method: notification.method}}
    end)
  end

  @doc ~S'''
  Sends a request to the client from the LSP process.

  ## Usage

  ```elixir
  GenLSP.request(lsp, %ClientRegisterCapability{
    id: System.unique_integer([:positive]),
    params: params
  })
  ```
  '''
  @spec request(GenLSP.LSP.t(), request :: any(), timeout :: atom() | non_neg_integer()) :: any()
  def request(%{buffer: buffer}, request, timeout \\ :infinity) do
    Logger.debug("sent request server -> client #{request.method}",
      id: request.id,
      method: request.method
    )

    :telemetry.span([:gen_lsp, :request, :server], %{}, fn ->
      result =
        GenLSP.Buffer.outgoing_sync(
          buffer,
          dump!(request.__struct__.schema(), request),
          timeout
        )

      result = unify!(request.__struct__.result(), result)

      {result, %{id: request.id, method: request.method}}
    end)
  end

  defp write_debug(device, event, name) do
    IO.write(device, "#{inspect(name)} event = #{inspect(event)}\n")
  end

  defp loop(%LSP{} = lsp, parent, deb) do
    receive do
      {:system, from, request} ->
        :sys.handle_system_msg(request, from, parent, __MODULE__, deb, lsp)

      {:request, from, request} ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :request, from})

        start = System.system_time(:microsecond)
        :telemetry.execute([:gen_lsp, :request, :client, :start], %{})

        attempt(
          lsp,
          "Last message received: handle_request #{inspect(request)}",
          [:gen_lsp, :request, :client],
          fn
            {:error, error} ->
              {:ok, output} =
                Schematic.dump(
                  GenLSP.ErrorResponse.schema(),
                  %GenLSP.ErrorResponse{
                    code: GenLSP.Enumerations.ErrorCodes.internal_error(),
                    message: error
                  }
                )

              packet = %{
                "jsonrpc" => "2.0",
                "id" => Process.get(:request_id),
                "error" => output
              }

              deb =
                :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

              GenLSP.Buffer.outgoing(lsp.buffer, packet)
              loop(lsp, parent, deb)

            _ ->
              case GenLSP.Requests.new(request) do
                {:ok, %{id: id} = req} ->
                  Process.put(:request_id, id)

                  result =
                    :telemetry.span([:gen_lsp, :handle_request], %{method: req.method}, fn ->
                      {lsp.mod.handle_request(req, lsp), %{}}
                    end)

                  case result do
                    {:reply, reply, %LSP{} = lsp} ->
                      response_key =
                        case reply do
                          %GenLSP.ErrorResponse{} -> "error"
                          _ -> "result"
                        end

                      # if result is valid, continue, if not, we return an internal error
                      {response_key, response} =
                        case Schematic.dump(req.__struct__.result(), reply) do
                          {:ok, output} ->
                            {response_key, output}

                          {:error, errors} ->
                            exception = InvalidResponse.exception({req.method, reply, errors})

                            Logger.error(Exception.format(:error, exception))

                            {:ok, output} =
                              Schematic.dump(
                                GenLSP.ErrorResponse.schema(),
                                %GenLSP.ErrorResponse{
                                  code: GenLSP.Enumerations.ErrorCodes.internal_error(),
                                  message: exception.message
                                }
                              )

                            {"error", output}
                        end

                      packet = %{
                        "jsonrpc" => "2.0",
                        "id" => id,
                        response_key => response
                      }

                      deb =
                        :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

                      GenLSP.Buffer.outgoing(lsp.buffer, packet)

                      duration = System.system_time(:microsecond) - start

                      Logger.debug(
                        "handled request client -> server #{req.method} in #{format_time(duration)}",
                        id: req.id,
                        method: req.method
                      )

                      :telemetry.execute([:gen_lsp, :request, :client, :stop], %{
                        duration: duration
                      })

                      loop(lsp, parent, deb)

                    {:noreply, lsp} ->
                      duration = System.system_time(:microsecond) - start

                      Logger.debug(
                        "handled request client -> server #{req.method} in #{format_time(duration)}",
                        id: req.id,
                        method: req.method
                      )

                      :telemetry.execute([:gen_lsp, :request, :client, :stop], %{
                        duration: duration
                      })

                      loop(lsp, parent, deb)
                  end

                {:error, errors} ->
                  # the payload is not parseable at all, other than being valid JSON and having
                  # an `id` property to signal its a request
                  exception = InvalidRequest.exception({request, errors})

                  Logger.error(Exception.format(:error, exception))

                  {:ok, output} =
                    Schematic.dump(
                      GenLSP.ErrorResponse.schema(),
                      %GenLSP.ErrorResponse{
                        code: GenLSP.Enumerations.ErrorCodes.invalid_request(),
                        message: exception.message
                      }
                    )

                  packet = %{
                    "jsonrpc" => "2.0",
                    "id" => request["id"],
                    "error" => output
                  }

                  deb =
                    :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

                  GenLSP.Buffer.outgoing(lsp.buffer, packet)

                  loop(lsp, parent, deb)
              end
          end
        )

      {:notification, from, notification} ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :notification, from})
        start = System.system_time(:microsecond)
        :telemetry.execute([:gen_lsp, :notification, :client, :start], %{})

        attempt(
          lsp,
          "Last message received: handle_notification #{inspect(notification)}",
          [:gen_lsp, :notification, :client],
          fn
            {:error, _} ->
              loop(lsp, parent, deb)

            _ ->
              case GenLSP.Notifications.new(notification) do
                {:ok, note} ->
                  result =
                    :telemetry.span(
                      [:gen_lsp, :handle_notification],
                      %{method: note.method},
                      fn ->
                        {lsp.mod.handle_notification(note, lsp), %{}}
                      end
                    )

                  case result do
                    {:noreply, %LSP{} = lsp} ->
                      duration = System.system_time(:microsecond) - start

                      Logger.debug(
                        "handled notification client -> server #{note.method} in #{format_time(duration)}",
                        method: note.method
                      )

                      :telemetry.execute([:gen_lsp, :notification, :client, :stop], %{
                        duration: duration
                      })

                      loop(lsp, parent, deb)
                  end

                {:error, errors} ->
                  # the payload is not parseable at all, other than being valid JSON
                  exception = InvalidNotification.exception({notification, errors})

                  Logger.warning(Exception.format(:error, exception))

                  deb =
                    :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

                  loop(lsp, parent, deb)
              end
          end
        )

      message ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :info, message})
        start = System.system_time(:microsecond)
        :telemetry.execute([:gen_lsp, :info, :start], %{})

        attempt(
          lsp,
          "Last message received: handle_info #{inspect(message)}",
          [:gen_lsp, :info],
          fn
            {:error, _} ->
              loop(lsp, parent, deb)

            _ ->
              result =
                :telemetry.span([:gen_lsp, :handle_info], %{}, fn ->
                  {lsp.mod.handle_info(message, lsp), %{}}
                end)

              case result do
                {:noreply, %LSP{} = lsp} ->
                  duration = System.system_time(:microsecond) - start
                  :telemetry.execute([:gen_lsp, :info, :stop], %{duration: duration})
                  loop(lsp, parent, deb)
              end
          end
        )
    end
  end

  defp format_time(time) when time < 1000 do
    "#{time}µs"
  end

  defp format_time(time) do
    "#{System.convert_time_unit(time, :microsecond, :millisecond)}ms"
  end

  @spec attempt(LSP.t(), String.t(), list(atom()), (:try | {:error, String.t()} -> any())) ::
          no_return()
  defp attempt(lsp, message, prefix, callback) do
    callback.(:try)
  rescue
    e ->
      :telemetry.execute(prefix ++ [:exception], %{message: message})

      message = Exception.format(:error, e, __STACKTRACE__)
      Logger.error(message)
      error(lsp, message)

      callback.({:error, message})
  end

  defp dump!(schematic, structure) do
    {:ok, output} = Schematic.dump(schematic, structure)
    output
  end

  defp unify!(schematic, structure) do
    {:ok, output} = Schematic.unify(schematic, structure)
    output
  end

  @doc false
  def system_continue(parent, deb, state) do
    loop(state, parent, deb)
  end

  @doc false
  def system_terminate(reason, _parent, _deb, _chs) do
    exit(reason)
  end

  @doc false
  def system_get_state(state) do
    {:ok, state}
  end

  @doc false
  def system_replace_state(state_fun, state) do
    new_state = state_fun.(state)

    {:ok, new_state, new_state}
  end

  @doc """
  Send a `window/logMessage` error notification to the client.

  See `GenLSP.Enumerations.MessageType.error/0`.

  ## Usage

  ```elixir
  GenLSP.error(lsp, "Failed to compiled!")
  ```
  """
  @spec error(GenLSP.LSP.t(), String.t()) :: :ok
  def error(lsp, message) do
    log_message(lsp, GenLSP.Enumerations.MessageType.error(), message)
  end

  @doc """
  Send a `window/logMessage` error notification to the client.

  See `GenLSP.Enumerations.MessageType.warning/0`.

  ## Usage

  ```elixir
  GenLSP.warning(lsp, "Variable `foo` is unused.")
  ```
  """
  @spec warning(GenLSP.LSP.t(), String.t()) :: :ok
  def warning(lsp, message) do
    log_message(lsp, GenLSP.Enumerations.MessageType.warning(), message)
  end

  @doc """
  Send a `window/logMessage` info notification to the client.

  See `GenLSP.Enumerations.MessageType.info/0`.

  ## Usage

  ```elixir
  GenLSP.info(lsp, "Compilation complete!")
  ```
  """
  @spec info(GenLSP.LSP.t(), String.t()) :: :ok
  def info(lsp, message) do
    log_message(lsp, GenLSP.Enumerations.MessageType.info(), message)
  end

  @doc """
  Send a `window/logMessage` log notification to the client.

  See `GenLSP.Enumerations.MessageType.log/0`.

  ## Usage

  ```elixir
  GenLSP.log(lsp, "Starting compilation.")
  ```
  """
  @spec log(GenLSP.LSP.t(), String.t()) :: :ok
  def log(lsp, message) do
    log_message(lsp, GenLSP.Enumerations.MessageType.log(), message)
  end

  defp log_message(lsp, level, message) do
    GenLSP.notify(lsp, %GenLSP.Notifications.WindowLogMessage{
      params: %GenLSP.Structures.LogMessageParams{
        type: level,
        message: message
      }
    })
  end
end
