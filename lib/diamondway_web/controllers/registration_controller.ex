defmodule DiamondwayWeb.RegistrationController do
  use DiamondwayWeb, :controller

  alias Diamondway.Guests
  alias Diamondway.Countries
  alias Diamondway.Guests.Guest

  plug :set_body_class, "opaque-header"

  defp set_body_class(conn, class) do
    assign(conn, :body_class, class)
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
    case Guests.create_guest(guest_params) do
      {:ok, guest} ->
        redirect(conn, to: Routes.registration_path(conn, :success))

      {:error, %Ecto.Changeset{} = changeset} ->
        countries = Countries.list_countries_for_select()
        render(conn, "new.html", changeset: changeset, countries: countries)
    end
  end
end
