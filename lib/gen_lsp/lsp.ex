defmodule GenLSP.LSP do
  use TypedStruct

  @doc """
  The LSP data structure.
  """
  typedstruct do
    field :mod, atom(), enforce: true
    field :assigns, map(), default: Map.new()
    field :buffer, atom() | pid()
    field :pid, pid()
  end

  @spec assign(t(), Keyword.t()) :: t()
  def assign(%__MODULE__{assigns: assigns} = lsp, new_assigns) when is_list(new_assigns) do
    %{lsp | assigns: Map.merge(assigns, Map.new(new_assigns))}
  end
end
