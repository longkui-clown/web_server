defmodule Main do
  use Application
  import Supervisor.Spec, warn: false
  # require Logger

  def start(_type, _args) do
    HttpService.start()
  end

end
