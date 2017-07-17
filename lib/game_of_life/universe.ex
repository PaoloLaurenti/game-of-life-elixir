defmodule GameOfLife.Universe do

  def start_link(cells) do
    {:ok, _pid} = Agent.start_link(fn() -> cells end)
  end

  def get_cells(universe_pid) do
    Agent.get(universe_pid, &(&1))
  end

end
