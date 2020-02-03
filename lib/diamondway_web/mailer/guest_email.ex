defmodule DiamondwayWeb.GuestEmail do
  use Phoenix.Swoosh, view: DiamondwayWeb.EmailView, layout: {DiamondwayWeb.EmailView, :layout}
  alias Diamondway.Guests

  email_types = Application.get_env(:diamondway, Diamondway.Emails) |> Keyword.get(:email_types)
  @email_types email_types

  def common(guest) do
    guest = Guests.preload_countries(guest)

    new()
    |> from({"Diamond Way Buddhism Taipei", "info@mahamudra.taipei"})
    |> to({"#{guest.first_name} #{guest.last_name}", guest.email})
  end

  def render_email(type, guest) when type in @email_types do
    apply(__MODULE__, type, [guest])
  end

  def backup(guest) do
    common(guest)
    |> subject("You are on the waiting list")
    |> render_body("backup.html", guest: guest)
  end

  def registration(guest) do
    common(guest)
    |> subject("Taipei Mahamudra Pre-registration")
    |> render_body("registration.html", guest: guest)
  end

  def payment(guest) do
    common(guest)
    |> subject("Status Update on Payments")
    |> render_body("status_update.html", guest: guest)
  end

  def last_call(guest) do
    common(guest)
    |> subject("Taipei Mahamudra Reminder")
    |> render_body("last_call.html", guest: guest)
  end

  def course_canceled(guest) do
    common(guest)
    |> subject("Taipei Course Canceled")
    |> render_body("course_canceled.html", guest: guest)
  end

  def confirmation(guest) do
    common(guest)
    |> subject("Taipei Mahamudra Confirmation")
    |> render_body("confirmation.html", guest: guest)
  end
end
