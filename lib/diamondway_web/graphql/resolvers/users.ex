defmodule DiamondwayWeb.GraphQL.Resolvers.Users do
  alias Diamondway.Users

  def current_user(_, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def list_users(_, _) do
    {:ok, Users.list_users()}
  end

  def get_user(%{id: id}, _) do
    {:ok, Users.get_user!(id)}
  end
end
