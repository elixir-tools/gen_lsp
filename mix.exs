defmodule GenLSP.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_lsp,
      version: "0.0.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs()
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
      {:jason, "~> 1.3"},
      {:logger_file_backend, "~> 0.0.13"}
    ]
  end

  defp docs() do
    [
      nest_modules_by_prefix: File.read!("mods.txt") |> String.split("\n")
    ]
  end
end
