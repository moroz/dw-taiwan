defmodule DiamondwayWeb.Plugs.RestrictAccess do
  import Plug.Conn

  alias Diamondway.Users
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _) do
    case Map.get(conn.assigns, :user) do
      %Users.User{} ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You are not authorized to see this page.")
        |> redirect(to: "/admin/login")
        |> halt()
    end
  end
end
