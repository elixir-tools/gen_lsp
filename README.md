# GenLSP

A behaviour for creating language servers.

Pre-alpha software, use only at great personal risk.

## Example

Here is an example of a [Credo](github.com/rrrene/credo) language server.

> **Warning**
> This example is probably out of date, but should still illustrate the general shape of a GenLSP process.

```elixir
defmodule CredoLS do
  use GenLSP

  alias GenLSP.Protocol.St, as: P

  def start_link(_) do
    GenLSP.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    CredoLS.DiagnosticCache.start_link()
    CredoLS.DiagnosticCache.refresh()

    {:ok, nil}
  end

  @impl true
  def handle_request(%P.Initialize{id: id}, state) do
    {:reply, id,
     %{
       "capabilities" => %{
         "textDocumentSync" => %{
           "openClose" => true,
           "save" => %{"includeText" => true}
         }
       },
       "serverInfo" => %{"name" => "SpeLS"}
     }, state}
  end

  @impl true
  def handle_notification(%P.Initialized{}, state) do
    {:noreply, state}
  end

  def handle_notification(%P.TextDocumentDidSave{}, state) do
    Task.start_link(fn -> CredoLS.DiagnosticCache.refresh() end)

    {:noreply, state}
  end

  def handle_notification(%P.TextDocumentDidOpen{}, state) do
    Task.start_link(fn -> CredoLS.DiagnosticCache.publish() end)

    {:noreply, state}
  end

  def handle_notification(%P.TextDocumentDidChange{}, state) do
    Task.start_link(fn ->
      CredoLS.DiagnosticCache.clear()
      CredoLS.DiagnosticCache.publish()
    end)

    {:noreply, state}
  end

  def handle_notification(%P.TextDocumentDidClose{}, state) do
    {:noreply, state}
  end

  def handle_notification(_thing, state) do
    {:noreply, state}
  end
end

defmodule CredoLS.DiagnosticCache do
  use Agent

  def start_link() do
    Agent.start_link(fn -> Map.new() end, name: __MODULE__)
  end

  def refresh() do
    clear()

    issues = Credo.Execution.get_issues(Credo.run(["--strict", "--all"]))

    GenLSP.log(:info, "[Credo] Found #{Enum.count(issues)} issues")

    for issue <- issues do
      diagnostic = %{
        "range" => %{
          "start" => %{line: issue.line_no - 1, character: issue.column || 0},
          "end" => %{line: issue.line_no, character: 0}
        },
        "severity" => category_to_severity(issue.category),
        "message" => """
          #{issue.message}

          ## Explanation

          #{issue.check.explanations()[:check]}
        """
      }

      put(Path.absname(issue.filename), diagnostic)
    end

    publish()
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def put(filename, diagnostic) do
    Agent.update(__MODULE__, fn cache ->
      Map.update(cache, Path.absname(filename), [diagnostic], fn v ->
        [diagnostic | v]
      end)
    end)
  end

  def clear() do
    Agent.update(__MODULE__, fn cache ->
      for {k, _} <- cache, into: Map.new() do
        {k, []}
      end
    end)
  end

  def publish() do
    for {file, diagnostics} <- get() do
      GenLSP.notify(%GenLSP.Protocol.TextDocumentPublishDiagnostics{
        params: %{
          "uri" => "file://#{file}",
          "diagnostics" => diagnostics
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

## TODO

- [x] Generate structs for the rest of the protocol.
    - [ ] Improve documentation for generated structs
- [ ] Communication: Support pipe: use pipes (Windows) or socket files (Linux, Mac) as the communication channel. The pipe / socket file name is passed as the next arg or with --pipe=.
- [ ] Communication: Support socket: uses a socket as the communication channel. The port is passed as next arg or with --port=.
- [ ] Documentation/tooling to package your language server into a single binary with [Burrito](https://github.com/burrito-elixir/burrito).

## Thank Yous

- Thank you to the [ElixirLS](github.com/elixir-lsp/elixir-ls) project for inspiration and answers to questions I had about the Language Server Protocol.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed by adding `lsp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_lsp, "~> 0.0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at <https://hexdocs.pm/gen_lsp>.
