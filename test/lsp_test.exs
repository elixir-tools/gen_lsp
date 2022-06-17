defmodule LspTest do
  use ExUnit.Case
  doctest Lsp

  test "greets the world" do
    assert Lsp.hello() == :world
  end
end
