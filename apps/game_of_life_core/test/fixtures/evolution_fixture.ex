defmodule GameOfLifeCore.Fixtures.EvolutionFixture do

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
      }
    ],
    [
      %{
        0 => %{0 => :alive, 1 => :alive, 2 => :dead},
        1 => %{0 => :alive, 1 => :alive, 2 => :dead},
        2 => %{0 => :alive, 1 => :dead, 2 => :alive},
        3 => %{0 => :dead, 1 => :alive, 2 => :alive},
      },
      %{
        0 => %{0 => :alive, 1 => :alive, 2 => :dead},
        1 => %{0 => :dead, 1 => :dead, 2 => :alive},
        2 => %{0 => :alive, 1 => :dead, 2 => :alive},
        3 => %{0 => :dead, 1 => :alive, 2 => :alive},
      },
      %{
        0 => %{0 => :dead, 1 => :alive, 2 => :dead},
        1 => %{0 => :alive, 1 => :dead, 2 => :alive},
        2 => %{0 => :dead, 1 => :dead, 2 => :alive},
        3 => %{0 => :dead, 1 => :alive, 2 => :alive},
      }
    ]
  ]

  def get_all, do: @evolutions

  def get_simple_evolution, do: Enum.at(@evolutions, 1)

end
