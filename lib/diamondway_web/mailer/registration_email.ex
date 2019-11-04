defmodule DiamondwayWeb.RegistrationEmail do
  use Phoenix.Swoosh, view: DiamondwayWeb.EmailView, layout: {DiamondwayWeb.EmailView, :layout}
  alias Diamondway.Guests

  @email_types ~w(registration payment confirmation)a

  def common(guest) do
    guest = Guests.preload_countries(guest)

    new()
    |> from({"Diamond Way Group Taipei", "no-reply@mahamudra.taipei"})
    |> to({"#{guest.first_name} #{guest.last_name}", guest.email})
  end

  def render_email(type, guest) when type in @email_types do
    apply(__MODULE__, type, [guest])
  end

  def registration(guest) do
    common(guest)
    |> subject("Taipei Mahamudra Pre-registration")
    |> render_body("registration.html", guest: guest)
  end

  def confirmation(guest) do
    common(guest)
    |> subject("Taipei Mahamudra Confirmation")
    |> render_body("confirmation.html", guest: guest)
  end
end
