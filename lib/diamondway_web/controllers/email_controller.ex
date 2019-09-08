defmodule DiamondwayWeb.EmailController do
  use DiamondwayWeb, :controller

  plug(:put_layout, {DiamondwayWeb.EmailView, :layout})
  import Ecto.Query
  alias Diamondway.Repo
  alias Diamondway.Guests
  alias Diamondway.Guests.Guest

  def action(conn, _) do
    guest = Repo.one(last(Guest)) |> Guests.preload_countries()
    email = %{subject: "Test email"}
    render(conn, "#{action_name(conn)}.html", %{guest: guest, email: email})
  end
end
