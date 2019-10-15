defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias DiamondwayWeb.GraphQL.Types
  alias DiamondwayWeb.GraphQL.Resolvers

  import_types(Absinthe.Type.Custom)
  import_types(Types.Guests)

  object :cursor do
    field :page, non_null(:integer)
    field :total_pages, non_null(:integer)
    field :total_entries, non_null(:integer)
  end

  query do
    import_fields(:guest_queries)
  end
end
