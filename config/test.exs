use Mix.Config

# Configure your database
config :diamondway, Diamondway.Repo,
  username: "postgres",
  password: "postgres",
  database: "diamondway_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :diamondway, DiamondwayWeb.Endpoint,
  http: [port: 4002],
  server: false

config :diamondway, DiamondwayWeb.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn
