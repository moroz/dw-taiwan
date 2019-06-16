defmodule DiamondwayWeb.PageController do
  use DiamondwayWeb, :controller

  @pages [:register, :venue, :faq, :contact]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  for page <- @pages do
    def unquote(page)(conn, _params) do
      render(conn, "#{unquote(page)}.html")
    end
  end
end
