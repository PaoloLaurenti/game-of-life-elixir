defmodule GameOfLife.Universe do
  @neighbours_places [:top_left, :top, :top_right, :left, :right, :bottom_left, :bottom, :bottom_right]
  @valid_cells_values [:dead, :alive]

  def evolve(universe) do
    case check(universe) do
      :ok -> evolve_safe(universe)
      {error, extra_info} -> {:error, error, extra_info}
      error -> {:error, error}
    end
  end

  defp check(universe) when is_map(universe) === false, do: :universe_is_not_a_map
  defp check(universe) do
    {check_values_response, invalid_cells} = check_values(universe)
    cond do
      universe === %{} -> :universe_empty
      !has_ordered_indexes?(universe) -> :universe_has_not_ordered_indexes
      !is_well_formed?(universe) -> :universe_is_not_well_formed
      check_values_response === :not_valid -> {:universe_contains_unrecognized_values, invalid_cells}
      true -> :ok
    end
  end

  defp has_ordered_indexes?(universe) do
    cols_ixs = Map.keys(universe) |> Enum.sort
    cols_ixs === Enum.to_list(0..(Enum.count(universe) - 1))
      && Enum.all?(universe, fn({_, rows}) ->
        Enum.sort(Map.keys(rows)) === Enum.to_list(0 ..(Enum.count(rows) - 1))
      end)
  end

  defp is_well_formed?(universe), do:
    Enum.all?(universe, fn({_, row}) -> Enum.count(row) === Enum.count(universe[0]) end)

  defp check_values(universe) do
    invalid_cells = for y <- Map.keys(universe), x <- Map.keys(universe[y]), into: [] do
      value = get_in(universe, [y, x])
      if !is_a_valid_cell_value?(value), do: {y, x, value}
    end
    |> Enum.filter(&(&1 !== nil))

    if(invalid_cells === []) do
      {:ok, []}
    else
      {:not_valid, invalid_cells}
    end
  end

  defp is_a_valid_cell_value?(value), do: Enum.member?(@valid_cells_values, value)

  defp evolve_safe(universe) do
    evolved_universe = map(universe, fn(x, y, cell) ->
      neighbours = get_all_neighbours(universe, {y, x})
      {:ok, evolved_cell} = GameOfLife.Cell.evolve(cell, neighbours)
      evolved_cell
    end)
    {:ok, evolved_universe}
  end

  defp map(universe, callback) do
    for y <- Map.keys(universe), into: %{} do
      mapped_cells = for x <- Map.keys(universe[y]), into: %{} do
        {x, callback.(x, y, universe[y][x])}
      end
      {y, mapped_cells}
    end
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

  def get_random_one({rows, cols}) do
    0..(rows - 1)
    |> Enum.reduce(%{}, fn(row_index, row_acc) ->
      row = 0..(cols - 1)
      |> Enum.reduce(%{}, fn(col_index, col_acc) -> Map.put_new(col_acc, col_index, get_random_cell_status()) end)

      Map.put_new(row_acc, row_index, row)
    end)
  end

  defp get_random_cell_status do
    r = :rand.uniform(100)
    if (rem(r, 2) === 0) do
      :alive
    else
      :dead
    end
  end

end
