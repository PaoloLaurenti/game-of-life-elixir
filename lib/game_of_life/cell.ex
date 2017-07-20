defmodule GameOfLife.Cell do
  @behaviour GameOfLife.Universe.CellBehaviour

  def evolve(cell, _neighbours) do
    {:ok, cell}
  end

end
