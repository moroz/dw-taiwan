defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias DiamondwayWeb.GraphQL.Types
  alias DiamondwayWeb.GraphQL.Actions

  import_types(Absinthe.Type.Custom)
  import_types(Types.Guests)
  import_types(Types.Users)
  import_types(Types.Audits)
  import_types(Types.Notes)
  import_types(Types.Dashboard)
  import_types(Actions.Guests)
  import_types(Actions.Notes)
  import_types(Actions.Dashboard)

  object :cursor do
    field :page, non_null(:integer)
    field :total_pages, non_null(:integer)
    field :total_entries, non_null(:integer)
    field :page_size, non_null(:integer)
  end

  query do
    import_fields(:guest_queries)
    import_fields(:user_queries)
    import_fields(:dashboard_queries)
  end

  mutation do
    import_fields(:guest_mutations)
    import_fields(:notes_mutations)
  end

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [DiamondwayWeb.GraphQL.Middleware.TransformErrors]
  end

  def middleware(middleware, _field, _object), do: middleware
end
