defmodule GameOfLife.Fixtures.Evolution do

  @evolutions [
    [
      %{
        0 => %{0 => :empty, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :empty},
        2 => %{0 => :empty, 1 => :empty, 2 => :empty},
      },
      %{
        0 => %{0 => :empty, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :empty},
        2 => %{0 => :empty, 1 => :empty, 2 => :empty},
      },
      %{
        0 => %{0 => :empty, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :empty},
        2 => %{0 => :empty, 1 => :empty, 2 => :empty},
      },
    ]
  ]

  def get_all, do: @evolutions

end
