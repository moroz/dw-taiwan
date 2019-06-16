defmodule DiamondwayWeb.SessionController do
  use DiamondwayWeb, :controller

  alias Diamondway.Users

  plug :put_layout, :admin

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user_by_email_password(email, password) do
      %Users.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: "/admin/guests")

      nil ->
        conn
        |> put_flash(:error, "Login failed for the given email and password combination.")
        |> render("new.html")
    end
  end
end
