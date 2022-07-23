defmodule GenLSP.Protocol.Structures do
  @structures_spec File.read!("metaModel.json")
                   |> Jason.decode!()
                   |> Map.get("structures")
                   |> Enum.map(fn s -> {s["name"], s} end)
                   |> Map.new()

  def spec, do: @structures_spec

  for {name, structure} <- @structures_spec do
    module_name = Module.concat(GenLSP.Protocol.Structures, name)

    properties =
      for p <- structure["properties"] do
        String.to_atom(p["name"])
      end

    defmodule module_name do
      @moduledoc """
      #{structure["documentation"]}

      ### Properties

      #{for p <- structure["properties"] do
        """
        #### #{p["name"]} :: #{p["type"]["name"] || "unimplemented doc type"} #{unless p["optional"], do: "(_required_)"}
        
        #{p["documentation"]}
        """
      end |> Enum.join("\n\n")}

      """

      @derive {Jason.Encoder, properties}
      defstruct properties

      defimpl GenLSP.Protocol.Encoder do
        def encode(structure) do
          Map.take(structure, unquote(properties))
        end
      end
    end
  end
end
