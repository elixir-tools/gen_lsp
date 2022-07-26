defmodule GenLSP.Protocol.Structures.Docs do
  defp type(%{"kind" => kind, "name" => name}) when kind in ["integer"] do
    name
  end

  defp type(%{"kind" => "reference", "name" => name}) do
    name
  end

  defp type(%{"kind" => "array", "element" => %{"kind" => "reference", "name" => name}}) do
    "[#{name}]"
  end

  defp type(_) do
    "unimplemented doc type"
  end

  defp doc_name(%{"name" => name, "type" => %{"name" => type_name}} = property) do
    title = "#{name} :: #{type_name}"

    unless property["optional"] do
      title <> " (_required_)"
    else
      title
    end
  end

  defp doc_name(%{"name" => name, "type" => %{"kind" => "or", "items" => items}} = property) do
    doc_items =
      Enum.map_join(items, " | ", fn item ->
        type(item)
      end)

    title = "#{name} :: #{doc_items}"

    if property["optional"] do
      title <> " (_required_)"
    else
      title
    end
  end

  defp doc_name(property) do
    title = "#{property["name"]} :: unimplemented doc type"

    if property["optional"] do
      title <> " (_required_)"
    else
      title
    end
  end

  @doc false
  def doc(property) do
    """
    #### #{doc_name(property)}

    #{property["documentation"]}
    """
  end
end

defmodule GenLSP.Protocol.Structures do
  @structures_spec File.read!("metaModel.json")
                   |> Jason.decode!()
                   |> Map.get("structures")
                   |> Enum.map(fn s -> {s["name"], s} end)
                   |> Map.new()

  def spec, do: @structures_spec

  for {name, structure} <- @structures_spec do
    module_name = Module.concat(GenLSP.Protocol.Structures, name)

    extends_properties =
      Enum.flat_map(structure["extends"] || [], fn extends ->
        @structures_spec[extends["name"]]["properties"]
      end)

    properties =
      for p <- structure["properties"] ++ extends_properties, uniq: true do
        String.to_atom(p["name"])
      end

    defmodule module_name do
      @moduledoc """
      #{structure["documentation"]}

      ### Properties

      #{for p <- structure["properties"] do
        GenLSP.Protocol.Structures.Docs.doc(p)
      end |> Enum.join("\n\n")}

      """

      @derive {Jason.Encoder, properties}
      defstruct properties

      defimpl GenLSP.Protocol.Encoder do
        def encode(structure) do
          Map.take(structure, unquote(properties))
        end

        for p <- properties do
          defp parse_property({unquote(to_string(p)), v}) do
            {unquote(p), v}
          end
        end

        defp parse_property(pass), do: pass

        def decode(structure, map) do
          struct(structure, Enum.map(map || [], &parse_property/1))
        end
      end
    end
  end
end
