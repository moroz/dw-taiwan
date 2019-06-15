defmodule Diamondway.Repo do
  use Ecto.Repo,
    otp_app: :diamondway,
    adapter: Ecto.Adapters.Postgres
end
