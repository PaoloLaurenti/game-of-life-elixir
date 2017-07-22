defmodule GameOfLife.Acceptance.EvolutionTest do
  use ExUnit.Case
  alias GameOfLife.Fixtures.EvolutionFixture

  describe "Evolution" do

    test "takes steps forward" do
      EvolutionFixture.get_all()
      |> Enum.each(&assert_evolutions/1)
    end

  end

  defp assert_evolutions([from | future_steps]) do
    {:ok, universe_pid} = GameOfLife.UniverseServer.start_link(from)
    {:ok, evolution_server_pid} = GameOfLife.EvolutionServer.start_link(universe_pid)

    assert_evolution(future_steps, evolution_server_pid)
  end

  defp assert_evolution([], _), do: nil
  defp assert_evolution([step | future_steps], evolution_server_pid) do
    {:ok, evolved_universe} = GameOfLife.EvolutionServer.step_forward(evolution_server_pid)

    assert evolved_universe === step
    assert_evolution(future_steps, evolution_server_pid)
  end

end
