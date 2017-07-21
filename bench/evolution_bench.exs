defmodule EvolutionBench do
  use Benchfella
  require Integer

  #1.2 sec avg
  before_each_bench _ do
    universe = get_random_universe({800, 800})
    {:ok, universe}
  end

  bench "universe evolution steps", [unused: bench_context] do
    {:ok, _} = GameOfLife.Universe.evolve(bench_context)
  end

  defp get_random_universe({rows, cols}) do
    0..(rows - 1)
    |> Enum.reduce(%{}, fn(row_index, row_acc) ->
      row = 0..(cols - 1)
      |> Enum.reduce(%{}, fn(col_index, col_acc) -> Map.put_new(col_acc, col_index, get_random_cell_status()) end)

      Map.put_new(row_acc, row_index, row)
    end)
  end

  defp get_random_cell_status do
    r = :rand.uniform(100)
    if (Integer.is_even(r)) do
      :alive
    else
      :dead
    end
  end
end
