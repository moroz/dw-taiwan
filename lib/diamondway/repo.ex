defmodule Diamondway.Repo do
  use Ecto.Repo,
    otp_app: :diamondway,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20
end
