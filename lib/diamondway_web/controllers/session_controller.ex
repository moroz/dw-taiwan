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

  def delete(conn, _) do
    conn |> clear_session() |> redirect(to: "/")
  end
end
