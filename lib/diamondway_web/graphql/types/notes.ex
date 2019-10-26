defmodule DiamondwayWeb.GraphQL.Types.Notes do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers

  object :note do
    field :timestamp, non_null(:datetime)
    field :body, non_null(:string)
    field :guest_name, non_null(:string)
    field :user_name, non_null(:string)
  end
end
