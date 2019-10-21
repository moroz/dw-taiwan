defmodule DiamondwayWeb.GraphQL.Types.Guests do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers
  alias Diamondway.Audits

  object :guest_queries do
    field :guests, non_null(:guest_page) do
      arg(:params, :guest_search_params)
      resolve(&Resolvers.Guests.filter_guests/2)
    end

    field :guest, :guest do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Guests.get_guest/2)
    end
  end

  enum :gender do
    value(:male)
    value(:female)
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
    field :sex, non_null(:gender)

    field :audits, non_null(list_of(non_null(:audit))) do
      resolve(fn guest, _, _ ->
        {:ok, Audits.list_guest_audits(guest)}
      end)
    end

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

  input_object :guest_search_params do
    field :name, :string
    field :page, :integer
  end
end
