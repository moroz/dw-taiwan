defmodule DiamondwayWeb.GraphQL.Actions.Guests do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers

  object :guest_queries do
    field :guests, non_null(:guest_page) do
      arg(:params, :guest_search_params, default_value: [])
      resolve(&Resolvers.Guests.filter_guests/2)
    end

    field :guest, :guest do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Guests.get_guest/2)
    end
  end

  object :guest_mutations do
    field :transition, :guest_mutation_response do
      arg(:id, non_null(:id))
      arg(:to_state, non_null(:guest_status))
      resolve(&Resolvers.Guests.transition_state/2)
    end

    field :add_note, :guest_mutation_response do
      arg(:id, non_null(:id))
      arg(:body, non_null(:string))
      resolve(&Resolvers.Guests.add_note/2)
    end

    field :send_email, :guest_mutation_response do
      arg(:id, non_null(:id))
      arg(:force, non_null(:boolean), default_value: false)
      arg(:type, non_null(:email_type))
      resolve(&Resolvers.Emails.send_email/2)
    end
  end
end
