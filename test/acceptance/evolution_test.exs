defmodule GameOfLife.Acceptance.EvolutionTest do
  use ExUnit.Case
  alias GameOfLife.Fixtures.EvolutionFixture

  describe "Evolution" do
    test "takes steps forward" do
      EvolutionFixture.get_all()
      |> Enum.each(&assert_evolutions/1)
    end
  end

  def assert_evolutions([from | future_steps]) do
    {:ok, universe_pid} = GameOfLife.Universe.start_link(from)
    {:ok, evolution_server_pid} = GameOfLife.Evolution.start_link(universe_pid)

    assert_evolution(future_steps, evolution_server_pid)
  end

  def assert_evolution([], _), do: nil
  def assert_evolution([step | future_steps], evolution_server_pid) do
    {:ok, evolved_universe} = GameOfLife.Evolution.step_forward(evolution_server_pid)

    assert step === evolved_universe
    assert_evolution(future_steps, evolution_server_pid)
  end

end
