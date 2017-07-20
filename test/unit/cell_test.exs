defmodule GameOfLife.Unit.CellTest do
  use ExUnit.Case

  @cells_statuses [:dead, :alive]

  describe "Cell evolution" do
    test "kills a cell for underpopulation" do
      for cell_status <- @cells_statuses do
        {:ok, result} = GameOfLife.Cell.evolve(cell_status, [:dead, :dead])
        assert result === :dead
      end
    end
  end

end
