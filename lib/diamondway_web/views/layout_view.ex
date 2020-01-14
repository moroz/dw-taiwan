defmodule DiamondwayWeb.LayoutView do
  use DiamondwayWeb, :view

  def html_tag(%Plug.Conn{} = conn) do
    case conn.assigns[:locale] do
      "zh" ->
        {:safe, ~s{<html lang=\"zh-Hant\">}}

      other ->
        {:safe, ~s{<html lang=\"#{other}\">}}
    end
  end
end
