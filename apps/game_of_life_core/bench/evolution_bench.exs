defmodule GameOfLifeCore.EvolutionBench do
  use Benchfella

  #1.2 sec avg
  before_each_bench _ do
    universe = GameOfLifeCore.Universe.get_random_one({800, 800})
    {:ok, universe}
  end

  bench "universe evolution steps", [unused: bench_context] do
    {:ok, _} = GameOfLifeCore.Universe.evolve(bench_context)
  end

end
