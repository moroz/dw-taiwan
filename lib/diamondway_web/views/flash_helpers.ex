defmodule DiamondwayWeb.FlashHelpers do
  import Phoenix.HTML.Tag
  import Phoenix.Controller, only: [get_flash: 1]

  def alert_class("error"), do: "notification is-danger"
  def alert_class("alert"), do: "notification is-danger"
  def alert_class(other) when is_binary(other), do: "alert alert-#{other}"

  def render_flash(%Plug.Conn{} = conn) do
    for {level, val} <- get_flash(conn) do
      content_tag(:div, [class: alert_class(level)], do: val)
    end
  end
end