defmodule DiamondwayWeb.PageController do
  use DiamondwayWeb, :controller

  @pages [:venue, :faq, :ticketing]

  plug DiamondwayWeb.Plugs.SetBodyClass, "opaque-header" when action != :index

  def index(conn, _params) do
    case Gettext.get_locale(DiamondwayWeb.Gettext) do
      "en" ->
        render(conn, "index.html")

      "zh" ->
        render(conn, "index.zh.html")
    end
  end

  for page <- @pages do
    def unquote(page)(conn, _params) do
      render(conn, "#{unquote(page)}.html")
    end
  end
end
