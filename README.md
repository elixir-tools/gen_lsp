# GenLSP

<!-- MDOC !-->

GenLSP is an OTP behaviour for building processes that implement the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/).

## Example

Here is an example of a [Credo](https://github.com/rrrene/credo) language server.

```elixir
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
```

<!-- MDOC !-->

## TODO

- [x] Generate structs for the rest of the protocol.
  - [x] Improve documentation for generated structs
- [x] Communication: Support socket: uses a socket as the communication channel. The port is passed as next arg or with --port=.
- [ ] Documentation/tooling to package your language server into a single binary with [Burrito](https://github.com/burrito-elixir/burrito).

## Thank Yous

- Thank you to the [ElixirLS](https://github.com/elixir-lsp/elixir-ls) project for inspiration and answers to questions I had about the Language Server Protocol.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed by adding `gen_lsp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_lsp, "~> 0.0.10"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/gen_lsp>.
