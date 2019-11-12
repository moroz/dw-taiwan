defmodule DiamondwayWeb.GraphQL.Types.Audits do
  use Absinthe.Schema.Notation

  object :audit do
    field :timestamp, non_null(:datetime)
    field :description, non_null(:string)
    field :guest_name, non_null(:string)
    field :user_name, non_null(:string)
    field :ip, :string
  end
end
