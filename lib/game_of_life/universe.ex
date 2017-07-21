defmodule GameOfLife.Universe do

  @neighbours_places [:top_left, :top, :top_right, :left, :right, :bottom_left, :bottom, :bottom_right]

  #TODO check universe is a map and well formed
  def evolve(universe) do
    evolved_universe = Enum.reduce(universe, %{}, fn({x, cells}, acc) ->
      evolved_cells = Enum.reduce(cells, %{}, fn({y, cell}, acc_row) ->
        neighbours = get_all_neighbours(universe, {x, y})
        {:ok, evolved_cell} = GameOfLife.Cell.evolve(cell, neighbours)
        Map.put(acc_row, y, evolved_cell)
      end)
      Map.put(acc, x, evolved_cells)
    end)
    {:ok, evolved_universe}
  end

  defp get_all_neighbours(universe, cell_coordinate) do
    Enum.reduce(@neighbours_places, [], fn(p, n_acc) ->
      case get_neighbour(universe, cell_coordinate, p) do
        nil -> n_acc
        neighbour -> [neighbour | n_acc]
      end
    end)
  end

  defp get_neighbour(universe, {x, y}, :top_left), do: universe[x - 1][y - 1]
  defp get_neighbour(universe, {x, y}, :top), do: universe[x][y - 1]
  defp get_neighbour(universe, {x, y}, :top_right), do: universe[x + 1][y - 1]
  defp get_neighbour(universe, {x, y}, :left), do: universe[x - 1][y]
  defp get_neighbour(universe, {x, y}, :right), do: universe[x + 1][y]
  defp get_neighbour(universe, {x, y}, :bottom_left), do: universe[x - 1][y + 1]
  defp get_neighbour(universe, {x, y}, :bottom), do: universe[x][y + 1]
  defp get_neighbour(universe, {x, y}, :bottom_right), do: universe[x + 1][y + 1]

end
