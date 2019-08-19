defmodule DiamondwayWeb.Plugs.SetBodyClass do
  import Plug.Conn

  def init(default), do: default

  def call(conn, class) when is_binary(class) do
    assign(conn, :body_class, class)
  end
end
