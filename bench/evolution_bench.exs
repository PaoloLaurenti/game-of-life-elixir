defmodule GameOfLife.EvolutionBench do
  use Benchfella

  #1.2 sec avg
  before_each_bench _ do
    universe = GameOfLife.Universe.get_random_one({800, 800})
    {:ok, universe}
  end

  bench "universe evolution steps", [unused: bench_context] do
    {:ok, _} = GameOfLife.Universe.evolve(bench_context)
  end

end
