defmodule Diamondway.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset
  import EmailTldValidator.Ecto

  @required ~w(city email first_name last_name reference_name reference_email phone sex nationality_id residence_id)a
  @all @required ++ ~w(single_person_registration travel_insurance visa_requirements)a
  @acceptance_message "Please confirm."

  schema "guests" do
    field :city, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :reference_email, :string
    field :reference_name, :string
    field :phone, :string

    field :sex, GuestSex

    belongs_to :nationality, Diamondway.Countries.Country
    belongs_to :residence, Diamondway.Countries.Country

    field :single_person_registration, :boolean, virtual: true
    field :travel_insurance, :boolean, virtual: true
    field :visa_requirements, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, @all)
    |> validate_required(@required, message: "This field is required.")
    |> unique_constraint(:email, message: "this address has already been used")
    |> validate_acceptance(:single_person_registration, message: "Please confirm.")
    |> validate_acceptance(:travel_insurance,
      message: "Please confirm."
    )
    |> validate_acceptance(:visa_requirements,
      message: "Please confirm."
    )
    |> validate_email()
    |> validate_email(:reference_email)
  end
end
