defmodule DiamondwayWeb.Plugs.FetchUser do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    user =
      conn
      |> fetch_cookies()
      |> Map.get(:cookies)
      |> case do
        %{"access_token" => token} when is_binary(token) ->
          case Diamondway.Guardian.resource_from_token(token) do
            {:ok, user, _claims} ->
              user

            _ ->
              nil
          end

        _ ->
          nil
      end

    context = %{current_user: user}

    assign(conn, :current_user, user)
    |> Absinthe.Plug.put_options(context: context)
  end
end
