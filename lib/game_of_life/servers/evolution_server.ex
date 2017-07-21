defmodule GameOfLife.EvolutionServer do
  use GenServer

  def start_link(universe_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [universe_pid])
  end

  def init([universe_server_pid]) do
    universe = GameOfLife.UniverseServer.get(universe_server_pid)
    {:ok, %{universe_pid: universe_server_pid, universe: universe}}
  end

  def step_forward(evolution_server_pid) do
    {:ok, _cells} = GenServer.call(evolution_server_pid, :step_forward)
  end

  def handle_call(:step_forward, _from, %{universe: universe} = state) do
    evolved_universe = GameOfLife.Universe.evolve(universe)
    {:reply, {:ok, evolved_universe}, Map.put(state, :universe, evolved_universe)}
  end

end
