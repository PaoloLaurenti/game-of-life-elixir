defmodule GameOfLife.Unit.UniverseTest do
  use ExUnit.Case
  import Mock

  describe "Universe" do

    @universe %{
      0 => %{0 => :alive, 1 => :dead, 2 => :dead},
      1 => %{0 => :dead, 1 => :alive, 2 => :dead},
      2 => %{0 => :alive, 1 => :dead, 2 => :alive},
    }

    @expected_evolutions_calls [
      %{cell: :alive, neighbours: [:dead, :dead, :alive]},
      %{cell: :dead, neighbours: [:alive, :dead, :dead, :alive, :dead]},
      %{cell: :dead, neighbours: [:dead, :alive, :dead]},
      %{cell: :dead, neighbours: [:alive, :dead, :alive, :alive, :dead]},
      %{cell: :alive, neighbours: [:alive, :dead, :dead, :dead, :dead, :alive, :dead, :alive]},
      %{cell: :dead, neighbours: [:dead, :dead, :alive, :dead, :alive]},
      %{cell: :alive, neighbours: [:dead, :alive, :dead]},
      %{cell: :dead, neighbours: [:dead, :alive, :dead, :alive, :alive]},
      %{cell: :alive, neighbours: [:alive, :dead, :dead]}
    ]

    test "evolves making cells evolve" do
      with_mock GameOfLife.Cell, [evolve: fn(cell, _neighbours) -> {:ok, cell} end] do

        GameOfLife.Universe.evolve(@universe)

        for cec <- @expected_evolutions_calls do
          assert_cell_evolution_call(cec)
        end
      end
    end

    test "returns error when evolving if the given universe is a map" do
       result = GameOfLife.Universe.evolve({})

       assert result == {:error, :universe_is_not_a_map}
    end

    test "returns error when evolving if the given universe is not well formed" do
        result = GameOfLife.Universe.evolve(%{0 => %{0 => :dead, 1 => :dead, 2 => :alive},
                                              1 => %{0 => :dead, 1 => :alive}})

        assert result == {:error, :universe_is_not_well_formed}
    end

    test "returns error when evolving if the given universe contains unrecognized values" do
      result = GameOfLife.Universe.evolve(%{0 => %{0 => :YYY, 1 => :alive, 2 => :alive},
                                            1 => %{0 => :XXX, 1 => :alive, 2 => :dead}})

      assert result == {:error, :universe_contains_unrecognized_values, [{0, 0, :YYY}, {1, 0, :XXX}]}
    end

    test "returns error when evolving if the given universe is empty" do
      result = GameOfLife.Universe.evolve(%{})

      assert result == {:error, :universe_empty}
    end

    test "returns error when evolving if the given universe has not ordered indexes" do
      result1 = GameOfLife.Universe.evolve(%{0 => %{0 => :dead, 1 => :alive, 2 => :alive},
                                            3 => %{0 => :alive, 1 => :alive, 2 => :dead}})
      result2 = GameOfLife.Universe.evolve(%{0 => %{0 => :alive, 1 => :alive, 2 => :alive},
                                            1 => %{0 => :dead, 4 => :alive, 2 => :dead}})

      assert result1 == {:error, :universe_has_not_ordered_indexes}
      assert result2 == {:error, :universe_has_not_ordered_indexes}
    end

    defp assert_cell_evolution_call(call) do
      try do
        assert called GameOfLife.Cell.evolve(call.cell, call.neighbours)
      rescue
        error ->
          IO.inspect call
          raise(error)
      end
    end

  end
end
