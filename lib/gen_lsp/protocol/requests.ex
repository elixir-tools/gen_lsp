defmodule GenLSP.Protocol.Requests do
  @requests_spec File.read!("metaModel.json")
                 |> Jason.decode!()
                 |> Map.get("requests")
                 |> Enum.map(fn s -> {s["method"], s} end)
                 |> Map.new()

  def spec, do: @requests_spec

  for {method, request} <- @requests_spec do
    module_name =
      method
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(GenLSP.Protocol.Requests, &1))

    defmodule module_name do
      @moduledoc """
      #{request["documentation"]}
      """
      defstruct id: nil, params: nil

      defimpl GenLSP.Protocol.Encoder do
        def encode(req) do
          %{
            "method" => unquote(request["method"]),
            "id" => req.id,
            "jsonrpc" => "2.0",
            "params" => GenLSP.Protocol.Encoder.encode(req.params)
          }
        end
      end
    end
  end
end
