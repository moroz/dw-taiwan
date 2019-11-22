defmodule DiamondwayWeb.API.PaymentController do
  use DiamondwayWeb, :controller
  alias Diamondway.Payments
  alias Diamondway.Guests

  require Logger

  def verify(conn, params) do
    case Payments.verify_payment(params) do
      {:ok, guest} ->
        Guests.mark_paid(guest, conn.assigns[:ip])
        send_resp(conn, 200, "1|OK")

      {:error, reason} ->
        send_resp(conn, 422, "0|#{reason}")
    end
  end
end
