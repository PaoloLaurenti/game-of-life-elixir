defmodule GameOfLife.Cell do

  def evolve(cell, neighbours) do
    live_neighbours_count = Enum.filter(neighbours, &(&1 === :alive)) |> length
    evolved_cell = cond do
      live_neighbours_count < 2 -> :dead
      live_neighbours_count === 2 -> cell
      live_neighbours_count === 3 -> :alive
      live_neighbours_count > 3 -> :dead
    end
    {:ok, evolved_cell}
  end

end
