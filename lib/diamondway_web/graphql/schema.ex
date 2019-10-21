defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias DiamondwayWeb.GraphQL.Types

  import_types(Absinthe.Type.Custom)
  import_types(Types.Guests)
  import_types(Types.Users)
  import_types(Types.Audits)

  object :cursor do
    field :page, non_null(:integer)
    field :total_pages, non_null(:integer)
    field :total_entries, non_null(:integer)
    field :page_size, non_null(:integer)
  end

  query do
    import_fields(:guest_queries)
    import_fields(:user_queries)
  end
end
