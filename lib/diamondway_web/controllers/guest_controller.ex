defmodule DiamondwayWeb.GuestController do
  use DiamondwayWeb, :controller

  alias Diamondway.Guests
  alias Diamondway.Guests.Guest

  plug :put_layout, :admin

  def index(conn, params) do
    page = Guests.paginate_guests(params)
    privileged_count = Guest.from_asia() |> Guests.count_guests()

    render(conn, "index.html",
      guests: page,
      page: page,
      privileged_count: privileged_count
    )
  end

  def new(conn, _params) do
    changeset = Guests.change_guest(%Guest{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    guest = Guests.get_guest!(id) |> Guests.preload_countries()
    render(conn, "show.html", guest: guest)
  end

  def edit(conn, %{"id" => id}) do
    guest = Guests.get_guest!(id)
    changeset = Guests.change_guest(guest)
    render(conn, "edit.html", guest: guest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "guest" => guest_params}) do
    guest = Guests.get_guest!(id)

    case Guests.update_guest(guest, guest_params) do
      {:ok, guest} ->
        conn
        |> put_flash(:info, "Guest updated successfully.")
        |> redirect(to: Routes.guest_path(conn, :show, guest))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", guest: guest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    guest = Guests.get_guest!(id)
    {:ok, _guest} = Guests.delete_guest(guest)

    conn
    |> put_flash(:info, "Guest deleted successfully.")
    |> redirect(to: Routes.guest_path(conn, :index))
  end
end
