defmodule DiamondwayWeb.PaymentController do
  use DiamondwayWeb, :controller
  alias Diamondway.Guests
  alias Diamondway.Payments
  plug DiamondwayWeb.Plugs.OpaqueHeader

  def show(conn, %{"token" => token}) do
    guest = Guests.get_guest_by_payment_token(token)
    payment_params = Payments.payment_params_for_guest(guest)
    render(conn, "show.html", guest: guest, payment_params: payment_params)
  end
end
