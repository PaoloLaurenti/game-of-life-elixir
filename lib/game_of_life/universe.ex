defmodule GameOfLife.Universe do

  def start_link(cells) do
    {:ok, _pid} = Agent.start_link(fn() -> cells end, name: __MODULE__)
  end

  def get_cells do
    Agent.get(__MODULE__, &(&1))
  end

end
