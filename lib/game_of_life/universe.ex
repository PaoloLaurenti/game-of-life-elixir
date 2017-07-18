defmodule GameOfLife.Universe do

  #TODO check universe is a map and well formed
  def evolve(universe) do
    Enum.reduce(universe, %{}, fn({x, cells}, acc) ->
      evolved_cells = Enum.reduce(cells, %{}, fn({y, cell}, acc_row) ->
        neighbours = []
        evolved_cell = GameOfLife.Cell.evolve(cell, neighbours)
        Map.put(acc_row, y, evolved_cell)
      end)
      Map.put(acc, x, evolved_cells)
    end)
  end

end
