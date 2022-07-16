defmodule GenLSP.Protocol.Notifications do
  @notifications_spec File.read!("metaModel.json")
                      |> Jason.decode!()
                      |> Map.get("notifications")
                      |> Enum.map(fn s -> {s["method"], s} end)
                      |> Map.new()

  def spec, do: @notifications_spec

  for {method, notification} <- @notifications_spec do
    module_name =
      method
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(GenLSP.Protocol.Notifications, &1))

    defmodule module_name do
      @moduledoc """
      #{notification["documentation"]}
      """
      defstruct params: nil

      defimpl GenLSP.Protocol.Encoder do
        def encode(note) do
          %{
            "method" => unquote(notification["method"]),
            "jsonrpc" => "2.0",
            "params" => GenLSP.Protocol.Encoder.encode(note.params)
          }
        end
      end
    end
  end
end
