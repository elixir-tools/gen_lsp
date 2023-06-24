defmodule GenLSP do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

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
                      default: GenLSP.Buffer,
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

  @doc """
  Sends a notification to the client from the LSP process.

  ## Usage

  ```elixir
  GenLSP.notify(lsp, %TextDocumentPublishDiagnostics{
    params: %PublishDiagnosticsParams{
      uri: "file://#\{file}",
      diagnostics: diagnostics
    }
  })
  ```
  """
  @spec notify(GenLSP.LSP.t(), notification :: any()) :: :ok
  def notify(%{buffer: buffer}, notification) do
    GenLSP.Buffer.outgoing(buffer, dump!(notification.__struct__.schematic(), notification))
  end

  defp write_debug(device, event, name) do
    IO.write(device, "#{inspect(name)} event = #{inspect(event)}")
  end

  defp loop(%LSP{} = lsp, parent, deb) do
    receive do
      {:system, from, request} ->
        :sys.handle_system_msg(request, from, parent, __MODULE__, deb, lsp)

      {:request, from, request} ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :request, from})

        attempt(
          lsp,
          "Last message received: handle_request #{inspect(request)}",
          fn ->
            {:ok, %{id: id} = req} = GenLSP.Requests.new(request)

            # GenLSP.log(lsp, :log, "[GenLSP] Processing #{inspect(req.__struct__)}")

            case lsp.mod.handle_request(req, lsp) do
              {:reply, reply, %LSP{} = lsp} ->
                response_key =
                  case reply do
                    %GenLSP.ErrorResponse{} -> "error"
                    _ -> "result"
                  end

                packet = %{
                  "jsonrpc" => "2.0",
                  "id" => id,
                  response_key => dump!(req.__struct__.result(), reply)
                }

                deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

                GenLSP.Buffer.outgoing(lsp.buffer, packet)

                loop(lsp, parent, deb)

              {:noreply, lsp} ->
                loop(lsp, parent, deb)
            end
          end
        )

      {:notification, from, notification} ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :notification, from})

        attempt(
          lsp,
          "Last message received: handle_notification #{inspect(notification)}",
          fn ->
            {:ok, note} = GenLSP.Notifications.new(notification)

            # GenLSP.log(lsp, :log, "[GenLSP] Processing #{inspect(note.__struct__)}")

            case lsp.mod.handle_notification(note, lsp) do
              {:noreply, %LSP{} = lsp} ->
                loop(lsp, parent, deb)
            end
          end
        )

      message ->
        attempt(
          lsp,
          "Last message received: handle_info #{inspect(message)}",
          fn ->
            case lsp.mod.handle_info(message, lsp) do
              {:noreply, %LSP{} = lsp} ->
                loop(lsp, parent, deb)
            end
          end
        )
    end
  end

  @spec attempt(LSP.t(), String.t(), (() -> any())) :: no_return()
  defp attempt(lsp, message, callback) do
    callback.()
  rescue
    e ->
      message = """
      LSP Exited.

      #{message}

      #{Exception.format(:error, e, __STACKTRACE__)}

      """

      error(lsp, message)
      Logger.error(message)

      reraise e, __STACKTRACE__
  end

  defp dump!(schematic, structure) do
    {:ok, output} = Schematic.dump(schematic, structure)
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
