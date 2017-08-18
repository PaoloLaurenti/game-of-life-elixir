defmodule GameOfLifeCore.UniverseServer do

  def start_link(game_id, cells) do
    {:ok, _pid} = Agent.start_link(fn() -> cells end, name: service_name(game_id))
  end

  def get(game_id) do
    Agent.get(service_name(game_id), &(&1))
  end

  def set(game_id, universe) do
    Agent.update(service_name(game_id), fn(_) -> universe end)
  end

  defp service_name(game_id), do: GameOfLifeCore.Application.service_name({__MODULE__, game_id})

end
