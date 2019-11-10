use Mix.Config

import_config "prod.exs"

config :diamondway, DiamondwayWeb.Endpoint,
  url: [host: "staging.mahamudra.taipei", port: 443, scheme: :https],
  http: [:inet6, port: System.get_env("PORT") || 4000],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :diamondway, DiamondwayWeb.Mailer, adapter: Swoosh.Adapters.Local
