# codegen: do not edit
defmodule GenLSP.TypeAlias.TextDocumentFilter do
  @moduledoc """
  A document filter denotes a document by different properties like
  the {@link TextDocument.languageId language}, the {@link Uri.scheme scheme} of
  its resource, or a glob-pattern that is applied to the {@link TextDocument.fileName path}.

  Glob patterns can have the following syntax:
  - `*` to match one or more characters in a path segment
  - `?` to match on one character in a path segment
  - `**` to match any number of path segments, including none
  - `{}` to group sub patterns into an OR expression. (e.g. `**​/*.{ts,js}` matches all TypeScript and JavaScript files)
  - `[]` to declare a range of characters to match in a path segment (e.g., `example.[0-9]` to match on `example.0`, `example.1`, …)
  - `[!...]` to negate a range of characters to match in a path segment (e.g., `example.[!0-9]` to match on `example.a`, `example.b`, but not `example.0`)

  @sample A language filter that applies to typescript files on disk: `{ language: 'typescript', scheme: 'file' }`
  @sample A language filter that applies to all package.json paths: `{ language: 'json', pattern: '**package.json' }`

  @since 3.17.0
  """

  import Schematic, warn: false

  @type t :: map() | map() | map()

  @doc false
  def schematic() do
    oneof([
      map(%{
        {"language", :language} => str(),
        {"scheme", :scheme} => oneof([null(), str()]),
        {"pattern", :pattern} => oneof([null(), str()])
      }),
      map(%{
        {"language", :language} => oneof([null(), str()]),
        {"scheme", :scheme} => str(),
        {"pattern", :pattern} => oneof([null(), str()])
      }),
      map(%{
        {"language", :language} => oneof([null(), str()]),
        {"scheme", :scheme} => oneof([null(), str()]),
        {"pattern", :pattern} => str()
      })
    ])
  end
end
