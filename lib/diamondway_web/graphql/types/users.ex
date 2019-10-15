defmodule DiamondwayWeb.GraphQL.Types.Users do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers

  object :user do
    field :id, non_null(:id)
    field :display_name, non_null(:string)
    field :email, non_null(:string)
  end

  object :user_queries do
    field :current_user, non_null(:user) do
      resolve(&Resolvers.Users.current_user/2)
    end
  end
end
