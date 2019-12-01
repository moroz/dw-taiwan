defmodule DiamondwayWeb.EmailController do
  use DiamondwayWeb, :controller

  plug(:put_layout, {DiamondwayWeb.EmailView, :layout})
  import Ecto.Query
  alias Diamondway.Repo
  alias Diamondway.Guests
  alias Diamondway.Guests.Guest
  alias Diamondway.Payments.PaymentToken

  def email(conn, %{"type" => "payment"}) do
    token = Repo.one!(last(PaymentToken))
    guest = Repo.one!(from g in Guest, where: g.id == ^token.guest_id)
    email = %{subject: "Test email"}
    render(conn, "payment.html", %{guest: guest, email: email, token: token.token})
  end

  def email(conn, %{"type" => type}) do
    guest = Repo.one(last(Guest)) |> Guests.preload_countries()
    email = %{subject: "Test email"}
    render(conn, "#{type}.html", %{guest: guest, email: email})
  end
end
