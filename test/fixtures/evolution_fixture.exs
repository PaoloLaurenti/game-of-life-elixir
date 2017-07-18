defmodule GameOfLife.Fixtures.EvolutionFixture do

  @evolutions [
    [
      %{
        0 => %{0 => :dead, 1 => :dead, 2 => :dead},
        1 => %{0 => :dead, 1 => :dead, 2 => :dead},
        2 => %{0 => :dead, 1 => :dead, 2 => :dead},
      },
      %{
        0 => %{0 => :dead, 1 => :dead, 2 => :dead},
        1 => %{0 => :dead, 1 => :dead, 2 => :dead},
        2 => %{0 => :dead, 1 => :dead, 2 => :dead},
      },
      %{
        0 => %{0 => :dead, 1 => :dead, 2 => :dead},
        1 => %{0 => :dead, 1 => :dead, 2 => :dead},
        2 => %{0 => :dead, 1 => :dead, 2 => :dead},
      }
    ],
    [
      %{
        0 => %{0 => :dead, 1 => :dead, 2 => :dead},
        1 => %{0 => :dead, 1 => :alive, 2 => :dead},
        2 => %{0 => :dead, 1 => :dead, 2 => :dead},
      },
      %{
        0 => %{0 => :dead, 1 => :dead, 2 => :dead},
        1 => %{0 => :dead, 1 => :dead, 2 => :dead},
        2 => %{0 => :dead, 1 => :dead, 2 => :dead},
      }
    ]
  ]

  def get_all, do: @evolutions

end
