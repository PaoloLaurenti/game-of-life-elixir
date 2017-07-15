defmodule GameOfLife.EvolutionTest do
  use ExUnit.Case

  @empty_universe %{
    0 => %{0 => :empty, 1 => :empty, 2 => :empty},
    1 => %{0 => :empty, 1 => :empty, 2 => :empty},
    2 => %{0 => :empty, 1 => :empty, 2 => :empty},
  }

  describe "Evolution" do
    test "takes a step from empty to empty" do
      GameOfLife.Universe.start_link(@empty_universe)
      GameOfLife.Evolution.start_link()

      universe_evolved = GameOfLife.Evolution.step_forward

      assert @empty_universe === universe_evolved
    end
  end

end
