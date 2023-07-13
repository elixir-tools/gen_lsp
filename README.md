# GenLSP

[![Discord](https://img.shields.io/badge/Discord-5865F3?style=flat&logo=discord&logoColor=white&link=https://discord.gg/nNDMwTJ8)](https://discord.gg/6XdGnxVA2A)
[![Hex.pm](https://img.shields.io/hexpm/v/gen_lsp)](https://hex.pm/packages/gen_lsp)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/gen_lsp/)
[![GitHub Discussions](https://img.shields.io/github/discussions/elixir-tools/discussions)](https://github.com/orgs/elixir-tools/discussions)

<!-- MDOC !-->

GenLSP is an OTP behaviour for building processes that implement the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/).

## Examples

<details>
<summary><a href="https://github.com/rrrene/credo">Credo</a> language server.</summary>

<pre>
defmodule Credo.Lsp do
  @moduledoc """
  LSP implementation for Credo.
  """
  use GenLSP

  alias GenLSP.Enumerations.TextDocumentSyncKind

  alias GenLSP.Notifications.{
    Exit,
    Initialized,
    TextDocumentDidChange,
    TextDocumentDidClose,
    TextDocumentDidOpen,
    TextDocumentDidSave
  }

  alias GenLSP.Requests.{Initialize, Shutdown}

  alias GenLSP.Structures.{
    InitializeParams,
    InitializeResult,
    SaveOptions,
    ServerCapabilities,
    TextDocumentSyncOptions
  }

  alias Credo.Lsp.Cache, as: Diagnostics

  def start_link(args) do
    GenLSP.start_link(__MODULE__, args, [])
  end

  @impl true
  def init(lsp, args) do
    cache = Keyword.fetch!(args, :cache)

    {:ok, assign(lsp, exit_code: 1, cache: cache)}
  end

  @impl true
  def handle_request(%Initialize{params: %InitializeParams{root_uri: root_uri}}, lsp) do
    {:reply,
     %InitializeResult{
       capabilities: %ServerCapabilities{
         text_document_sync: %TextDocumentSyncOptions{
           open_close: true,
           save: %SaveOptions{include_text: true},
           change: TextDocumentSyncKind.full()
         }
       },
       server_info: %{name: "Credo"}
     }, assign(lsp, root_uri: root_uri)}
  end

  def handle_request(%Shutdown{}, lsp) do
    {:noreply, assign(lsp, exit_code: 0)}
  end

  @impl true
  def handle_notification(%Initialized{}, lsp) do
    GenLSP.log(lsp, :log, "[Credo] LSP Initialized!")
    Diagnostics.refresh(lsp.assigns.cache, lsp)
    Diagnostics.publish(lsp.assigns.cache, lsp)

    {:noreply, lsp}
  end

  def handle_notification(%TextDocumentDidSave{}, lsp) do
    Task.start_link(fn ->
      Diagnostics.clear(lsp.assigns.cache)
      Diagnostics.refresh(lsp.assigns.cache, lsp)
      Diagnostics.publish(lsp.assigns.cache, lsp)
    end)

    {:noreply, lsp}
  end

  def handle_notification(%TextDocumentDidChange{}, lsp) do
    Task.start_link(fn ->
      Diagnostics.clear(lsp.assigns.cache)
      Diagnostics.publish(lsp.assigns.cache, lsp)
    end)

    {:noreply, lsp}
  end

  def handle_notification(%note{}, lsp)
      when note in [TextDocumentDidOpen, TextDocumentDidClose] do
    {:noreply, lsp}
  end

  def handle_notification(%Exit{}, lsp) do
    System.halt(lsp.assigns.exit_code)

    {:noreply, lsp}
  end

  def handle_notification(_thing, lsp) do
    {:noreply, lsp}
  end
end


defmodule Credo.Lsp.Cache do
  @moduledoc """
  Cache for Credo diagnostics.
  """
  use Agent

  alias GenLSP.Structures.{
    Diagnostic,
    Position,
    PublishDiagnosticsParams,
    Range
  }

  alias GenLSP.Notifications.TextDocumentPublishDiagnostics

  def start_link(_) do
    Agent.start_link(fn -> Map.new() end)
  end

  def refresh(cache, lsp) do
    dir = URI.new!(lsp.assigns.root_uri).path

    issues = Credo.Execution.get_issues(Credo.run(["--strict", "--all", "#{dir}/**/*.ex"]))

    GenLSP.log(lsp, :info, "[Credo] Found #{Enum.count(issues)} issues")

    for issue <- issues do
      diagnostic = %Diagnostic{
        range: %Range{
          start: %Position{line: issue.line_no - 1, character: issue.column || 0},
          end: %Position{line: issue.line_no, character: 0}
        },
        severity: category_to_severity(issue.category),
        message: """
        #{issue.message}

        ## Explanation

        #{issue.check.explanations()[:check]}
        """
      }

      put(cache, Path.absname(issue.filename), diagnostic)
    end
  end

  def get(cache) do
    Agent.get(cache, & &1)
  end

  def put(cache, filename, diagnostic) do
    Agent.update(cache, fn cache ->
      Map.update(cache, Path.absname(filename), [diagnostic], fn v ->
        [diagnostic | v]
      end)
    end)
  end

  def clear(cache) do
    Agent.update(cache, fn cache ->
      for {k, _} <- cache, into: Map.new() do
        {k, []}
      end
    end)
  end

  def publish(cache, lsp) do
    for {file, diagnostics} <- get(cache) do
      GenLSP.notify(lsp, %TextDocumentPublishDiagnostics{
        params: %PublishDiagnosticsParams{
          uri: "file://#{file}",
          diagnostics: diagnostics
        }
      })
    end
  end

  def category_to_severity(:refactor), do: 1
  def category_to_severity(:warning), do: 2
  def category_to_severity(:design), do: 3
  def category_to_severity(:consistency), do: 4
  def category_to_severity(:readability), do: 4
end
</pre>

</details>

<!-- MDOC !-->

## Built with GenLSP

- [credo-language-server](https://github.com/elixir-tools/credo-language-server)

## Thank Yous

- Thank you to the [ElixirLS](https://github.com/elixir-lsp/elixir-ls) project for inspiration and answers to questions I had about the Language Server Protocol.

## Installation

This package can be installed by adding `gen_lsp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_lsp, "~> 0.3"}
  ]
end
```

Documentation can be found at <https://hexdocs.pm/gen_lsp>.
