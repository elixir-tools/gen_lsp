defmodule GenLSP.Protocol do
  require Logger

  def encode(struct) do
    GenLSP.Protocol.Encoder.encode(struct)
  end

  defp decode_property(_packet, nil) do
    nil
  end

  defp decode_property(packet, spec) do
    structure =
      Module.concat(GenLSP.Protocol.Structures, spec["name"])
      |> struct()
      |> GenLSP.Protocol.Encoder.decode(packet)

    props =
      for {k, v} <- Map.from_struct(structure) do
        properties =
          Map.get(spec, "properties") ++
            Enum.flat_map(spec["extends"] || [], fn e ->
              GenLSP.Protocol.Structures.spec()[e["name"]]["properties"]
            end)

        p_spec =
          Enum.find_value(
            properties,
            fn
              %{"name" => name, "type" => %{"name" => p_type, "kind" => kind}} ->
                if name == to_string(k), do: {kind, p_type}

              %{"name" => name} ->
                if name == to_string(k), do: {"base", :idk}
            end
          )

        decoded_value =
          case p_spec do
            {"reference", p_type} when p_type not in ["LSPAny"] ->
              p_type
              |> then(&Map.get(GenLSP.Protocol.Structures.spec(), &1))
              |> then(&decode_property(v, &1))

            _ ->
              v
          end

        {k, decoded_value}
      end

    struct(structure, props)
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

    Logger.debug("[GenLSP] Decoding #{method}")

    structure =
      GenLSP.Protocol.Structures.spec()[requests_and_notfications[method]["params"]["name"]]

    struct(struct,
      id: packet["id"],
      params: decode_property(packet["params"], structure)
    )
  end
end
