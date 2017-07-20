defmodule GameOfLife.Cell do

  def evolve(_cell, neighbours) do
    live_neighbours_count = Enum.filter(neighbours, &(&1 === :alive)) |> Enum.count
    evolve(live_neighbours_count)
  end

  defp evolve(live_neighbours_count) when live_neighbours_count < 2, do: {:ok, :dead}

end
