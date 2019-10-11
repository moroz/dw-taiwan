defmodule DiamondwayWeb.SessionController do
  use DiamondwayWeb, :controller

  alias Diamondway.Users

  plug :put_layout, :admin

  def new(conn, _) do
    case conn.assigns[:current_user] do
      nil ->
        render(conn, "new.html")

      %Users.User{} ->
        redirect(conn, to: "/admin")
    end
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user_by_email_password(email, password) do
      %Users.User{} = user ->
        {:ok, token, _claims} = Diamondway.Guardian.encode_and_sign(user)

        conn
        |> put_resp_cookie("access_token", token, secure: true)
        |> redirect(to: "/admin")

      nil ->
        conn
        |> put_flash(:error, "Login failed for the given email and password combination.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    delete_resp_cookie(conn, "access_token", secure: true)
    |> put_flash(:info, "You have been signed out.")
    |> redirect(to: "/")
  end
end
