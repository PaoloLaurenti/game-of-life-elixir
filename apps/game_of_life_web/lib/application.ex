defmodule GameOfLifeWeb.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    port = Application.get_env(:game_of_life_web, :cowboy_port, 8080)

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, GameOfLifeWeb.Router, [], port: port)
    ]

    Logger.info "Started application"

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameOfLifeWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
