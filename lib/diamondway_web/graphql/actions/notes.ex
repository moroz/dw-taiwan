defmodule DiamondwayWeb.GraphQL.Actions.Notes do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers.Notes

  object :notes_mutations do
    field :create_note, :guest_mutation_response do
      arg(:guest_id, non_null(:id))
      arg(:body, non_null(:string))
      resolve(&Notes.create_guest_note/2)
    end
  end
end
