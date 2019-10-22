defmodule DiamondwayWeb.GraphQL.Types.Guests do
  use Absinthe.Schema.Notation
  alias Diamondway.Audits

  enum :gender do
    value(:male)
    value(:female)
  end

  enum :guest_status do
    value(:unverified)
    value(:verified)
    value(:invited)
    value(:backup)
    value(:canceled)
    value(:paid)
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
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :sex, non_null(:gender)
    field :status, non_null(:guest_status)

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
