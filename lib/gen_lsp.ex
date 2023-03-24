defmodule GenLSP do
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
        Logger.warn("Unhandled message passed to handle_info/2")

        {:noreply, state}
      end

      defoverridable handle_info: 2
    end
  end

  require Logger

  @callback init(lsp :: GenLSP.LSP.t(), init_arg :: term()) :: {:ok, GenLSP.LSP.t()}
  @callback handle_request(request :: term(), state) ::
              {:reply, id :: integer(), reply :: term(), state} | {:noreply, state}
            when state: GenLSP.LSP.t()
  @callback handle_notification(notification :: term(), state) :: {:noreply, state}
            when state: GenLSP.LSP.t()
  @callback handle_info(message :: any(), state) :: {:noreply, state} when state: GenLSP.LSP.t()

  def start_link(module, init_args, opts) do
    :proc_lib.start_link(__MODULE__, :init, [
      {module, init_args, Keyword.take(opts, [:name, :buffer]), self()}
    ])
  end

  @doc false
  def init({module, init_args, opts, parent}) do
    me = self()
    buffer = Keyword.get(opts, :buffer, GenLSP.Buffer)
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

  def request_server(pid, request) do
    from = self()
    message = {:request, from, request}
    send(pid, message)
  end

  def notify_server(pid, notification) do
    from = self()
    send(pid, {:notification, from, notification})
  end

  def notify(%{buffer: buffer}, notification) do
    GenLSP.Buffer.outgoing(buffer, dump(notification))
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
          fn ->
            {:ok, %{id: id} = req} = GenLSP.Requests.new(request)

            GenLSP.log(lsp, :log, "[GenLSP] Processing #{inspect(req.__struct__)}")

            case lsp.mod.handle_request(req, lsp) do
              {:reply, reply, %LSP{} = lsp} ->
                packet = %{
                  "jsonrpc" => "2.0",
                  "id" => id,
                  "result" => dump(reply)
                }

                deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:out, :request, from})

                GenLSP.Buffer.outgoing(lsp.buffer, packet)

                loop(lsp, parent, deb)

              {:noreply, lsp} ->
                loop(lsp, parent, deb)
            end
          end,
          "Last message received: handle_request #{inspect(request)}"
        )

      {:notification, from, notification} ->
        deb = :sys.handle_debug(deb, &write_debug/3, __MODULE__, {:in, :notification, from})

        attempt(
          fn ->
            {:ok, note} = GenLSP.Notifications.new(notification)
            GenLSP.log(lsp, :log, "[GenLSP] Processing #{inspect(note.__struct__)}")

            case lsp.mod.handle_notification(note, lsp) do
              {:noreply, %LSP{} = lsp} ->
                loop(lsp, parent, deb)
            end
          end,
          "Last message received: handle_notification #{inspect(notification)}"
        )

      message ->
        attempt(
          fn ->
            case lsp.mod.handle_info(message, lsp) do
              {:noreply, %LSP{} = lsp} ->
                loop(lsp, parent, deb)
            end
          end,
          "Last message received: handle_info #{inspect(message)}"
        )
    end
  end

  @spec attempt((() -> any()), String.t()) :: no_return()
  defp attempt(callback, message) do
    callback.()
  rescue
    e ->
      Logger.error("""
      LSP Exited.

      #{message}

      #{Exception.format(:error, e, __STACKTRACE__)}

      """)

      reraise e, __STACKTRACE__
  end

  defp dump(%struct{} = structure) do
    Schematic.dump(struct.schematic(), structure)
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

  def log(lsp, level, message) when level in [:error, :warning, :info, :log] do
    GenLSP.notify(lsp, %GenLSP.Notifications.WindowLogMessage{
      params: %GenLSP.Structures.LogMessageParams{
        type: GenLSP.Log.level(level),
        message: message
      }
    })
  end
end
