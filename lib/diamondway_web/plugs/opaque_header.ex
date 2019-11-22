defmodule DiamondwayWeb.Plugs.OpaqueHeader do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    assign(conn, :body_class, "opaque-header")
  end
end
