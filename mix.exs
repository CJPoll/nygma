defmodule Nygma.MixProject do
  use Mix.Project

  def project do
    [
      app: :nygma,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Nygma.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:liquid, "~> 0.9.0"},
      {:phoenix, "~> 1.4.3"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.13", override: true},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view,
       git: "https://github.com/phoenixframework/phoenix_live_view",
       ref: "9a53a0005f54a38aa297f9046374bace72348a8e"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:predicator, "~> 0.7.0"},
      {:schemata, path: "../schemata"},
      {:yaml_elixir, "~> 2.1.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
