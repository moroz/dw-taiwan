defmodule DiamondwayWeb.Plugs.FetchUser do
  import Plug.Conn

  alias Diamondway.Users

  def init(default), do: default

  def call(conn, _) do
    case get_session(conn, :user_id) do
      user_id when is_integer(user_id) ->
        user = Users.get_user!(user_id)
        assign(conn, :user, user)

      _ ->
        conn
    end
  end
end
