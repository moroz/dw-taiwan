defmodule Diamondway.MixProject do
  use Mix.Project

  def project do
    [
      app: :diamondway,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() in [:prod, :staging],
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Diamondway.Application, []},
      extra_applications: [:logger, :runtime_tools, :xmerl]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5", override: true},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0", override: true},
      {:cowboy, "~> 2.7", override: true},
      {:plug_cowboy, "~> 2.0"},
      {:ecto_enum, "~> 1.3"},
      {:email_tld_validator, "~> 0.1.0"},
      {:timex, "~> 3.6", override: true},
      {:ecto_network, "~> 1.2.0"},

      # State machines
      {:machinery, github: "joaomdmoura/machinery"},

      # Testing
      {:ex_machina, "~> 2.3", only: :test},
      {:mock, "~> 0.3"},

      # CSV generation
      {:nimble_csv, "~> 0.6.0"},

      # Localization
      {:set_locale, "~> 0.2.8"},

      # Pagination
      {:scrivener_ecto, "~> 2.0"},
      {:scrivener_html, "~> 1.8"},

      # Sending emails
      {:swoosh, "~> 0.23"},
      {:gen_smtp, "~> 0.14"},
      {:phoenix_swoosh, "~> 0.2"},
      {:oban, "~> 0.12"},

      # Payment
      {:ecpay, git: "https://gitlab.com/moroz2137/ecpay_elixir"},

      # Deployment
      {:distillery, "~> 2.1"},
      {:mix_systemd, github: "cogini/mix_systemd", override: true},
      {:mix_deploy, github: "cogini/mix_deploy", override: true},

      # GraphQL
      {:absinthe, "~> 1.4"},
      {:absinthe_plug, "~> 1.4"},

      # User authentication
      {:comeonin, "~> 4.1"},
      {:guardian, "~> 1.2"},
      {:argon2_elixir, "~> 1.3"},
      {:bodyguard, "~> 2.4.0"},
      {:speakeasy, "~> 0.3.0"},

      # Templating
      {:phoenix_slime, "~> 0.12.0"}
    ]
  end

  defp releases do
    [
      diamondway: [
        include_executables_for: [:unix]
      ]
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "deploy.remote": ["cmd bin/deploy-remote"]
    ]
  end
end
