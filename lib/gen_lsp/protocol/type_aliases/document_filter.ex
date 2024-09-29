# codegen: do not edit
defmodule GenLSP.TypeAlias.DocumentFilter do
  @moduledoc """
  A document filter describes a top level text document or
  a notebook cell document.

  @since 3.17.0 - proposed support for NotebookCellTextDocumentFilter.
  """

  import Schematic, warn: false

  @type t ::
          GenLSP.TypeAlias.TextDocumentFilter.t()
          | GenLSP.Structures.NotebookCellTextDocumentFilter.t()

  @doc false
  @spec schema() :: Schematic.t()
  def schema() do
    oneof([
      GenLSP.TypeAlias.TextDocumentFilter.schema(),
      GenLSP.Structures.NotebookCellTextDocumentFilter.schema()
    ])
  end
end
