defmodule DiamondwayWeb.AdminController do
  use DiamondwayWeb, :controller
  alias Diamondway.Guests.CSVGenerator
  plug :put_layout, {DiamondwayWeb.LayoutView, :admin}

  def csv_export(conn, _params) do
    csv = CSVGenerator.get_guests_csv()
    file_name = CSVGenerator.readable_file_name()

    conn
    |> put_resp_header("content-type", "text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"#{file_name}\"")
    |> send_resp(200, csv)
  end

  def react(conn, _params) do
    render(conn, "react.html")
  end
end
