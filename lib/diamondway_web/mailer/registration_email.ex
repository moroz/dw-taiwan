defmodule DiamondwayWeb.RegistrationEmail do
  use Phoenix.Swoosh, view: DiamondwayWeb.EmailView, layout: {DiamondwayWeb.EmailView, :layout}
  alias Diamondway.Guests

  def registration(guest) do
    guest = Guests.preload_countries(guest)

    new()
    |> from({"Diamond Way Group Taipei", "no-reply@mahamudra.taipei"})
    |> to({"#{guest.first_name} #{guest.last_name}", guest.email})
    |> subject("Taipei Mahamudra Pre-registration")
    |> render_body("registration.html", guest: guest)
  end

  def confirmation(guest) do
    guest = Guests.preload_countries(guest)

    new()
    |> from({"Diamond Way Group Taipei", "no-reply@mahamudra.taipei"})
    |> to({"#{guest.first_name} #{guest.last_name}", guest.email})
    |> subject("Taipei Mahamudra Confirmation")
    |> render_body("confirmation.html", guest: guest)
  end
end
