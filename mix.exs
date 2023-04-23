defmodule GenLSP.MixProject do
  use Mix.Project

  @source_url "https://github.com/mhanberg/gen_lsp"

  def project do
    [
      app: :gen_lsp,
      description: "Library for creating language servers",
      source_url: @source_url,
      version: "0.0.11",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs(),
      package: package(),
      dialyzer: [
        plt_add_apps: [:ex_unit]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:typed_struct, "~> 0.3.0"},
      {:jason, "~> 1.3"},
      {:nimble_options, "~> 0.5 or ~> 1.0"},
      # {:schematic, path: "../schematic"},
      {:schematic, "~> 0.0.10"},
      {:dialyxir, ">= 0.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs() do
    [
      main: "GenLSP",
      nest_modules_by_prefix: [
        "GenLSP.Requests",
        "GenLSP.Notifications",
        "GenLSP.Enumerations",
        "GenLSP.TypeAlias",
        "GenLSP.Structures"
      ]
    ]
  end

  defp package() do
    [
      maintainers: ["Mitchell Hanberg"],
      licenses: ["MIT"],
      links: %{
        GitHub: @source_url,
        Sponsor: "https://github.com/sponsors/mhanberg"
      },
      files: ~w(lib LICENSE mix.exs README.md .formatter.exs)
    ]
  end
end
