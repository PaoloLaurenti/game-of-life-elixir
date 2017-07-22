defmodule GameOfLife.Acceptance.EvolutionTest do
  use ExUnit.Case
  alias GameOfLife.Fixtures.EvolutionFixture
  alias GameOfLife.EvolutionServer

  describe "Evolution" do

    test "takes steps forward" do
      EvolutionFixture.get_all()
      |> Enum.each(fn(e) -> assert_evolutions(:erlang.unique_integer(), e) end)
    end

  end

  defp assert_evolutions(game_id, [from | future_steps]) do
    GameOfLife.EvolutionServer.start(game_id, from)

    Enum.each(future_steps, fn(s) -> assert_evolution(game_id, s) end)
  end

  defp assert_evolution(game_id, step) do
    {:ok, evolved_universe} = EvolutionServer.step_forward(game_id)
    assert evolved_universe === step
  end

end
