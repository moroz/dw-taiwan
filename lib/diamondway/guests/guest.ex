defmodule Diamondway.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(city country email first_name last_name reference_name reference_email)a
  @all @required ++ ~w(single_person_registration travel_insurance visa_requirements)a

  schema "guests" do
    field :city, :string
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :reference_email, :string
    field :reference_name, :string

    field :single_person_registration, :boolean, virtual: true
    field :travel_insurance, :boolean, virtual: true
    field :visa_requirements, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, @all)
    |> validate_required(@required)
    |> unique_constraint(:email)
    |> validate_acceptance(:single_person_registration)
    |> validate_acceptance(:travel_insurance)
    |> validate_acceptance(:visa_requirements)
  end
end
