defmodule GameOfLife.Evolution do
  use GenServer

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [  ], name: __MODULE__)
  end

  def step_forward do
    GameOfLife.Universe.get_cells
  end

end
