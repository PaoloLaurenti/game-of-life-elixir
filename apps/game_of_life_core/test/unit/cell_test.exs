defmodule GameOfLife.Unit.CellTest do
  use ExUnit.Case

  alias GameOfLifeCore.Cell

  describe "Cell evolution" do
    test "kills a live cell with less than two live neighbours for underpopulation" do
        {:ok, result} = Cell.evolve(:alive, [:dead, :dead, :alive])
        assert result === :dead
    end

    test "leaves a cell alive if it has two live neighbours" do
      {:ok, result} = Cell.evolve(:alive, [:dead, :alive, :dead, :alive])
      assert result === :alive
    end

    test "leaves a cell alive if it has three live neighbours" do
      {:ok, result} = Cell.evolve(:alive, [:dead, :alive, :alive, :alive])
      assert result === :alive
    end

    test "kills a live cell with more than three live neighbours for overpopulation" do
        {:ok, result} = Cell.evolve(:alive, [:dead, :alive, :alive, :alive, :alive, :dead])
        assert result === :dead
    end

    test "revives a dead cell with three live neighbours for reproduction" do
        {:ok, result} = Cell.evolve(:dead, [:dead, :alive, :alive, :alive, :dead])
        assert result === :alive
    end
  end

end
