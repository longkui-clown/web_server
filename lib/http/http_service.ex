defmodule HttpService do
  require Logger

  def start() do
    port = Application.get_env(:pressure_test, :cowboy_port, Application.get_env(:web_server, :port, 80))

    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugRouter, options: [port: port]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
