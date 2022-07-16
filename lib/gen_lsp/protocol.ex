defmodule GenLSP.Protocol do
  def encode(struct) do
    GenLSP.Protocol.Encoder.encode(struct)
  end

  defp decode_property(packet, spec) do
    props = spec |> Map.get("properties") |> Enum.map(& &1["name"])

    struct(
      Module.concat(GenLSP.Protocol.Structures, spec["name"]),
      for {k, v} <- packet, k in props do
        p_spec =
          spec
          |> Map.get("properties")
          |> Enum.find_value(fn %{"name" => name, "type" => %{"name" => p_type, "kind" => kind}} ->
            if name == k, do: {kind, p_type}
          end)

        decoded_value =
          case p_spec do
            {"reference", p_type} ->
              p_type
              |> then(&Map.get(GenLSP.Protocol.Structures.spec(), &1))
              |> then(&decode_property(v, &1))

            _ ->
              v
          end

        {String.to_existing_atom(k), decoded_value}
      end
    )
  end

  def new(%{"method" => method} = packet) do
    packet_type =
      if Map.has_key?(packet, "id"),
        do: GenLSP.Protocol.Requests,
        else: GenLSP.Protocol.Notifications

    struct =
      method
      |> String.split("/")
      |> Enum.map_join("", &Macro.camelize/1)
      |> String.to_atom()
      |> then(&Module.concat(packet_type, &1))

    requests_and_notfications =
      Map.merge(GenLSP.Protocol.Requests.spec(), GenLSP.Protocol.Notifications.spec())

    structure =
      GenLSP.Protocol.Structures.spec()[requests_and_notfications[method]["params"]["name"]]

    struct(struct,
      id: packet["id"],
      params: decode_property(packet["params"], structure)
    )
  end
end
