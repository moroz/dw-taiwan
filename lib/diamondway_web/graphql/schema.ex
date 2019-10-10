defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  object :guest do
    field :id, non_null(:id)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
  end

  query do
    field :guests, non_null(list_of(non_null(:guest))) do
    end
  end
end
