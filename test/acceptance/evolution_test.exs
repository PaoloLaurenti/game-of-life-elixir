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

  describe "Resilience configuration" do
    test "allows evolution to start again from the evolution step where it's crashed" do
      game_id = 1
      [from | [first_step | [second_step | []]]] = EvolutionFixture.get_simple_evolution()
      {:ok, _} = EvolutionServer.start(game_id, from)
      {:ok, ^first_step} = EvolutionServer.step_forward(game_id)

      look_up_pid(GameOfLife.EvolutionServer, game_id)
      |> Process.exit(:kill)
      wait_until(fn() -> look_up_pid(GameOfLife.EvolutionServer, game_id) === nil end)
      wait_until(fn() -> look_up_pid(GameOfLife.EvolutionServer, game_id) !== nil end)

      assert_evolution(game_id, second_step)
    end
  end

  defp assert_evolutions(game_id, [from | future_steps]) do
    EvolutionServer.start(game_id, from)

    Enum.each(future_steps, fn(s) -> assert_evolution(game_id, s) end)
  end

  defp assert_evolution(game_id, step) do
    {:ok, evolved_universe} = EvolutionServer.step_forward(game_id)
    assert evolved_universe === step
  end

  defp look_up_pid(module, game_id) do
    case Registry.lookup(GameOfLife.Registry, {module, game_id}) do
       [{pid, _}] -> pid
       [] -> nil
       _ -> raise("Error looking up pif for #{IO.inspect(module)} - #{IO.inspect(game_id)}")
    end
  end

  defp wait_until(predicate, attempts \\ 15, sleep \\ 10)
  defp wait_until(_predicate, 0, _sleep), do: nil
  defp wait_until(predicate, attempts, sleep) do
    if predicate.() do
      wait_until(predicate, 0, sleep)
    else
      :timer.sleep(sleep)
      wait_until(predicate, attempts - 1, sleep)
    end
  end

end
