defmodule GenLSP.Protocol do
  @requests_spec File.read!("metaModel.json") |> Jason.decode!() |> Map.get("requests")
  @notifications_spec File.read!("metaModel.json") |> Jason.decode!() |> Map.get("notifications")

  defprotocol Encoder do
    def encode(struct)
  end

  def encode(struct) do
    GenLSP.Protocol.Encoder.encode(struct)
  end

  def new(packet) do
    struct =
      packet["method"]
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(GenLSP.Protocol, &1))

    struct(struct, id: packet["id"], params: packet["params"])
  end

  for request <- @requests_spec do
    module_name =
      request["method"]
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(GenLSP.Protocol, &1))

    defmodule module_name do
      defstruct id: nil, params: nil

      defimpl Encoder do
        def encode(req) do
          %{
            "method" => unquote(request["method"]),
            "id" => req.id,
            "jsonrpc" => "2.0",
            "params" => req.params
          }
        end
      end
    end
  end

  for notification <- @notifications_spec do
    module_name =
      notification["method"]
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(GenLSP.Protocol, &1))

    defmodule module_name do
      defstruct params: nil

      defimpl Encoder do
        def encode(note) do
          %{
            "method" => unquote(notification["method"]),
            "jsonrpc" => "2.0",
            "params" => note.params
          }
        end
      end
    end
  end
end
