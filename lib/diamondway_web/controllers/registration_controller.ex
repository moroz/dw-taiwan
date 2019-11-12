defmodule DiamondwayWeb.RegistrationController do
  use DiamondwayWeb, :controller

  alias Diamondway.Guests
  alias Diamondway.Emails
  alias Diamondway.Countries
  alias Diamondway.Guests.Guest

  plug :set_body_class, "opaque-header"

  defp set_body_class(conn, class) do
    assign(conn, :body_class, class)
  end

  def check_status_form(conn, _params) do
    render(conn, "check_status_form.html")
  end

  def check_status(conn, %{"email" => email}) do
    case Guests.get_guest_by_email(email) do
      nil ->
        conn
        |> put_flash(:error, "E-mail not found.")
        |> render("check_status_form.html")

      %Guest{} = guest ->
        waiting_list_no = Guests.get_waiting_list_number(guest)
        render(conn, "check_status.html", guest: guest, waiting_list_no: waiting_list_no)
    end
  end

  def resend_email(conn, %{"email" => email}) do
    case Guests.get_guest_by_email(email) do
      %Guest{status: :invited} = guest ->
        Emails.request_email_resend(guest, conn.remote_ip)
        render(conn, "email_resent.html", guest: guest, success: true)

      _ ->
        render(conn, "email_resent.html", success: false)
    end
  end

  def new(conn, _params) do
    changeset = Guests.change_guest(%Guest{})
    countries = Countries.list_countries_for_select()
    render(conn, "new.html", changeset: changeset, countries: countries)
  end

  def success(conn, _params) do
    render(conn, "success.html")
  end

  def create(conn, %{"guest" => guest_params}) do
    case Guests.create_guest_and_send_email(guest_params) do
      {:ok, _guest} ->
        redirect(conn, to: Routes.registration_path(conn, :success))

      {:error, %Ecto.Changeset{} = changeset} ->
        countries = Countries.list_countries_for_select()
        render(conn, "new.html", changeset: changeset, countries: countries)
    end
  end
end
