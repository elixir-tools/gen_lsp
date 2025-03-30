defmodule GenLSP.Assigns do
  use Agent

  def start_link(opts \\ []) do
    Agent.start_link(fn -> Map.new() end, Keyword.take(opts, [:name]))
  end

  def get(agent) do
    Agent.get(agent, & &1)
  end

  def merge(agent, new_assigns) do
    Agent.update(agent, &Map.merge(&1, Map.new(new_assigns)))
  end

  def update(agent, callback) do
    Agent.update(agent, fn assigns ->
      new_assigns = callback.(assigns)
      Map.merge(assigns, Map.new(new_assigns))
    end)
  end
end
