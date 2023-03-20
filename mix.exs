defmodule GenLSP.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_lsp,
      description: "Library for creating language servers",
      version: "0.0.2",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs(),
      package: package()
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
      {:schematic, "~> 0.0.3"}
    ]
  end

  defp docs() do
    [
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
      links: %{github: "https://github.com/mhanberg/gen_lsp"},
      files: ~w(lib LICENSE mix.exs README.md .formatter.exs)
    ]
  end
end
