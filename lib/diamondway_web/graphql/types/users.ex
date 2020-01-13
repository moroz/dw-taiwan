defmodule DiamondwayWeb.GraphQL.Types.Users do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers
  alias Diamondway.Users

  object :user do
    field :id, non_null(:id)
    field :display_name, non_null(:string)
    field :email, non_null(:string)
    field :avatar_url, :string
    field :human, non_null(:boolean)
    field :admin, non_null(:boolean)
  end

  object :user_queries do
    field :current_user, non_null(:user) do
      resolve(&Resolvers.Users.current_user/2)
    end

    field :list_users, non_null(list_of(non_null(:user))) do
      middleware(Speakeasy.Authn)
      middleware(Speakeasy.Authz, {Users, :list_users})
      resolve(&Resolvers.Users.list_users/2)
    end
  end
end
