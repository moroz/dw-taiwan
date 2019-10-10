defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias DiamondwayWeb.GraphQL.Types
  alias DiamondwayWeb.GraphQL.Resolvers

  import_types(Absinthe.Type.Custom)

  enum :gender do
    value(:male)
    value(:female)
  end

  object :cursor do
    field :page, non_null(:integer)
    field :total_pages, non_null(:integer)
    field :total_entries, non_null(:integer)
  end

  object :guest do
    field :id, non_null(:id)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :city, :string
    field :email, :string
    field :reference_email, :string
    field :reference_name, :string
    field :phone, :string
    field :notes, :string
    field :inserted_at, :datetime
    field :updated_at, :datetime

    field :nationality, non_null(:string) do
      resolve(fn
        %{nationality: %{name: name}}, _, _ ->
          {:ok, name}

        _, _, _ ->
          {:ok, nil}
      end)
    end

    field :residence, non_null(:string) do
      resolve(fn
        %{residence: %{name: name}}, _, _ ->
          {:ok, name}

        _, _, _ ->
          {:ok, nil}
      end)
    end
  end

  object :guest_page do
    field :entries, non_null(list_of(non_null(:guest)))
    field :cursor, non_null(:cursor)
  end

  query do
    field :guests, non_null(:guest_page) do
      resolve(&Resolvers.Guests.filter_guests/2)
    end
  end
end
