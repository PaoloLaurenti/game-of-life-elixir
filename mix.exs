defmodule GameOfLife.Mixfile do
  use Mix.Project

  def project do
    [app: :game_of_life,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     elixirc_paths: elixirc_paths(Mix.env),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {GameOfLife.Application, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/fixtures"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:mock, "~> 0.2.0", only: :test},
      {:benchfella, "~> 0.3.0"}
    ]
  end
end
