defmodule Diamondway.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guests" do
    field :city, :string
    field :country, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :reference_email, :string
    field :reference_name, :string

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:first_name, :last_name, :email, :country, :city, :reference_name, :reference_email])
    |> validate_required([:first_name, :last_name, :email, :country, :city, :reference_name, :reference_email])
    |> unique_constraint(:email)
  end
end
