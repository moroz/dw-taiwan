# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :diamondway,
  ecto_repos: [Diamondway.Repo]

# Configures the endpoint
config :diamondway, DiamondwayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "b5bApytQC7xm0CkIT+qe4+/+TLOAlzFIZqScme/9qL5iRXBfh9xZie+auEOnOkS1",
  render_errors: [view: DiamondwayWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Diamondway.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :diamondway, DiamondwayWeb.Mailer, adapter: Swoosh.Adapters.Local

config :diamondway, DiamondwayWeb.Gettext, default_locale: "en", locales: ~w(en zh)

config :diamondway, Diamondway.Emails, email_types: ~w(registration confirmation payment backup)a

config :scrivener_html, view_style: :bulma

config :diamondway, Diamondway.Guardian,
  issuer: "diamondway",
  secret_key: "EEw6QTfn9QkkVYBiFkqzlvqGsW6mqHsfeIW0iffMc4Yhod2X8eSLo6hMvfK4zfdr"

config :diamondway, course_price: 4800

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
