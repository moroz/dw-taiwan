defmodule DiamondwayWeb.PaymentController do
  use DiamondwayWeb, :controller
  alias Diamondway.Guests
  alias Diamondway.Payments
  plug DiamondwayWeb.Plugs.OpaqueHeader

  def show(conn, %{"token" => token}) do
    case Guests.get_guest_by_payment_token(token) do
      %Guests.Guest{} = guest ->
        payment_params = Payments.payment_params_for_guest(guest, token)
        render(conn, "show.html", guest: guest, payment_params: payment_params)

      nil ->
        render(conn, "not_found.html")
    end
  end
end
