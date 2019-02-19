defmodule WebServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :web_server,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: applications(),
      mod: {Main, []},
      included_applications: []
    ]
  end

  def applications() do
    [
      :timex, 
      :tzdata,
      :poolboy, 
      :changed_reloader, 
      :poison, 
      :httpoison, 
      :jason, 
      :plug_cowboy, 
      :eex_html,
      :logger
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:quantum, "~> 2.0"},
      {:timex, "~> 3.0"},
      {:poison, "~> 3.0"},
      {:poolboy, ">= 0.0.0"},
      {:httpoison, "~> 0.13"},
      {:changed_reloader, "~> 0.1.4"},
      {:recon, "~> 2.3.6"},
      {:tzdata, "~> 0.5.19"},
      {:distillery, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:crontab, "~> 1.1"},
      {:logger_file_backend, "~> 0.0.10"},
      {:plug_cowboy, "~> 2.0"},
      {:eex_html, "~> 0.2.0"}
    ]
  end

end
