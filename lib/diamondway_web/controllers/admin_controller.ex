defmodule DiamondwayWeb.AdminController do
  use DiamondwayWeb, :controller

  plug :put_layout, {DiamondwayWeb.LayoutView, :admin}

  def react(conn, _params) do
    render(conn, "react.html")
  end
end
