defmodule GameOfLife.EvolutionServer do
  use GenServer
  import Supervisor.Spec

  @evolution_supervisor GameOfLife.EvolutionSup

  def child_spec(),
    do:
      supervisor(
        Supervisor,
        [
          [supervisor(__MODULE__, [], function: :start_supervisor)],
          [strategy: :simple_one_for_one, name: @evolution_supervisor]
        ],
        id: @evolution_supervisor)

  def start(game_id, universe_size) when is_tuple(universe_size) do
     start(game_id, GameOfLife.Universe.get_random_one(universe_size))
  end
  def start(game_id, universe) do
    Supervisor.start_child(@evolution_supervisor, [game_id, universe])
  end

  def start_supervisor(game_id, universe) do
    Supervisor.start_link(
      [
        worker(GameOfLife.UniverseServer, [game_id, universe]),
        worker(__MODULE__, [game_id])
      ],
      strategy: :one_for_one
    )
  end

  def start_link(game_id) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [game_id], name: service_name(game_id))
  end

  def init([game_id]) do
    universe = GameOfLife.UniverseServer.get(game_id)
    {:ok, %{game_id: game_id, universe: universe}}
  end

  def step_forward(game_id) do
    {:ok, _cells} = GenServer.call(service_name(game_id), :step_forward)
  end

  def handle_call(:step_forward, _from, %{game_id: game_id, universe: universe} = state) do
    {:ok, evolved_universe} = GameOfLife.Universe.evolve(universe)
    GameOfLife.UniverseServer.set(game_id, evolved_universe)
    {:reply, {:ok, evolved_universe}, %{state | universe: evolved_universe}}
  end

  defp service_name(game_id), do: GameOfLife.Application.service_name({__MODULE__, game_id})

end
