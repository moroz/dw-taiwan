defmodule DiamondwayWeb.RegistrationEmail do
  use Phoenix.Swoosh, view: DiamondwayWeb.EmailView, layout: {DiamondwayWeb.EmailView, :layout}
  alias DiamondwayWeb.Mailer
  alias Diamondway.Guests

  def confirmation(guest) do
    guest = Guests.preload_countries(guest)

    new()
    |> from({"Diamond Way Group Taipei", "no-reply@mahamudra.taipei"})
    |> to("k.j.moroz@gmail.com")
    |> subject("Taipei Mahamudra Pre-registration")
    |> render_body("registration.html", guest: guest)
  end
end
