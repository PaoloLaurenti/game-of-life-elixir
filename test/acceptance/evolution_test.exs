defmodule GameOfLife.Acceptance.EvolutionTest do
  use ExUnit.Case

  describe "Evolution" do
    test "takes steps forward" do
      GameOfLife.Fixtures.Evolution.get_all()
      |> Enum.each(&assert_evolutions/1)
    end
  end

  def assert_evolutions([from | future_steps]) do
    GameOfLife.Universe.start_link(from)
    GameOfLife.Evolution.start_link()

    assert_evolution(future_steps)
  end

  def assert_evolution([]), do: nil
  def assert_evolution([step | future_steps]) do
    universe_evolved = GameOfLife.Evolution.step_forward

    assert step === universe_evolved
    assert_evolution(future_steps)
  end

end
