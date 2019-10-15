defmodule DiamondwayWeb.Plugs.RestrictAccess do
  import Plug.Conn

  alias Diamondway.Users
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, :api) do
    case Map.get(conn.assigns, :current_user) do
      %Users.User{} ->
        conn

      _ ->
        conn
        |> send_resp(401, "")
        |> halt()
    end
  end

  def call(conn, _) do
    case Map.get(conn.assigns, :current_user) do
      %Users.User{} ->
        conn

      _ ->
        conn
        |> put_flash(:info, "Please sign in to proceed.")
        |> redirect(to: "/admin/login")
        |> halt()
    end
  end
end
