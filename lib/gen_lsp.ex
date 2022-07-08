defmodule GenLSP do
  @moduledoc """
  René Föhring (@rrrene)
  """
  defmacro __using__(_) do
    quote do
      @behaviour GenLSP

      def child_spec(opts) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [opts]},
          type: :worker,
          restart: :permanent,
          shutdown: 500
        }
      end
    end
  end

  require Logger

  @callback init(init_arg :: term()) :: {:ok, state} when state: any()
  @callback handle_request(request :: term(), state) ::
              {:reply, id :: integer(), reply :: term(), state}
              | {:noreply, state}
            when state: any()
  @callback handle_notification(notification :: term(), state) :: {:noreply, state}
            when state: any()

  def start_link(module, init_args, opts) do
    :proc_lib.start_link(__MODULE__, :init, [
      {module, init_args, opts[:name], self()}
    ])
  end

  @doc false
  def init({module, init_args, name, parent}) do
    case module.init(init_args) do
      {:ok, user_state} ->
        deb = :sys.debug_options([])
        if name, do: Process.register(self(), name)
        :proc_lib.init_ack(parent, {:ok, self()})
        state = %{user_state: user_state, internal_state: %{mod: module}}

        loop(state, parent, deb)
    end
  end

  def request_server(lsp, request) do
    from = self()
    message = {:request, from, request}
    send(lsp, message)
  end

  def notify_server(lsp, notification) do
    from = self()
    send(lsp, {:notification, from, notification})
  end

  def notify(notification) do
    notification
    |> GenLSP.Protocol.encode()
    |> GenLSP.Buffer.outgoing()
  end

  defp loop(state, parent, deb) do
    receive do
      {:system, from, request} ->
        :sys.handle_system_msg(request, from, parent, __MODULE__, deb, state)

      {:request, _from, request} ->
        attempt(
          fn ->
            req = GenLSP.Protocol.new(request)

            case state.internal_state.mod.handle_request(req, state.user_state) do
              {:reply, id, reply, new_user_state} ->
                packet = %{
                  "jsonrpc" => "2.0",
                  "id" => id,
                  "result" => reply
                }

                GenLSP.Buffer.outgoing(packet)

                loop(Map.put(state, :user_state, new_user_state), parent, deb)

              {:noreply, new_user_state} ->
                loop(Map.put(state, :user_state, new_user_state), parent, deb)
            end
          end,
          "Last message received: handle_request #{inspect(request)}"
        )

      {:notification, _from, notification} ->
        attempt(
          fn ->
            note = GenLSP.Protocol.new(notification)

            case state.internal_state.mod.handle_notification(note, state.user_state) do
              {:noreply, new_user_state} ->
                loop(Map.put(state, :user_state, new_user_state), parent, deb)
            end
          end,
          "Last message received: handle_notification #{inspect(notification)}"
        )

      _msg ->
        loop(state, parent, deb)
    end
  end

  defp attempt(callback, message) do
    callback.()
  rescue
    e ->
      Logger.error("""
      LSP Exited.

      #{message}

      #{Exception.format_banner(:error, e, __STACKTRACE__)}

      """)

      reraise e, __STACKTRACE__
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

  def log(level, message) when level in [:error, :warning, :info, :log] do
    GenLSP.notify(%GenLSP.Protocol.WindowLogMessage{
      params: %{"type" => GenLSP.Communication.LogLevel.level(level), "message" => message}
    })
  end
end
