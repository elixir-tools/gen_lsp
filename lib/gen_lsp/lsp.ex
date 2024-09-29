defmodule GenLSP.LSP do
  use TypedStruct

  @doc """
  The LSP data structure.
  """
  typedstruct do
    field :mod, atom(), enforce: true
    field :buffer, atom() | pid()
    field :assigns, atom() | pid()
    field :pid, pid()
    field :tasks, %{integer() => pid()}
    field :task_supervisor, atom() | pid()
  end

  @spec assign(t(), Keyword.t() | (map() -> keyword())) :: t()
  def assign(%__MODULE__{assigns: assigns} = lsp, new_assigns) when is_list(new_assigns) do
    GenLSP.Assigns.merge(assigns, new_assigns)

    lsp
  end

  def assign(%__MODULE__{assigns: assigns} = lsp, callback) when is_function(callback, 1) do
    GenLSP.Assigns.update(assigns, callback)

    lsp
  end

  @spec assigns(t()) :: map()
  def assigns(%__MODULE__{assigns: assigns}) do
    GenLSP.Assigns.get(assigns)
  end
end
