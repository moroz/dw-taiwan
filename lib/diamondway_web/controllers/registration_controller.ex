defmodule DiamondwayWeb.RegistrationController do
  use DiamondwayWeb, :controller

  alias Diamondway.Guests
  alias Diamondway.Countries
  alias Diamondway.Guests.Guest

  def new(conn, _params) do
    changeset = Guests.change_guest(%Guest{})
    countries = Countries.list_countries_for_select()
    render(conn, "new.html", changeset: changeset, countries: countries)
  end

  def create(conn, %{"guest" => guest_params}) do
    case Guests.create_guest(guest_params) do
      {:ok, guest} ->
        conn
        |> put_flash(:info, "Guest created successfully.")
        |> redirect(to: Routes.guest_path(conn, :show, guest))

      {:error, %Ecto.Changeset{} = changeset} ->
        countries = Countries.list_countries_for_select()
        render(conn, "new.html", changeset: changeset, countries: countries)
    end
  end
end
