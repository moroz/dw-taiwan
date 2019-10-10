defmodule DiamondwayWeb.GraphQL.Schema do
  use Absinthe.Schema

  alias DiamondwayWeb.GraphQL.Types
  alias DiamondwayWeb.GraphQL.Resolvers

  import_types(Absinthe.Type.Custom)

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
  end

  query do
    field :guests, non_null(list_of(non_null(:guest))) do
      resolve(&Resolvers.Guests.filter_guests/2)
    end
  end
end
