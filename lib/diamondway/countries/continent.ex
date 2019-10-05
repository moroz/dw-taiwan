defmodule Diamondway.Countries.Continent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "continents" do
    field :name, :string
    has_many :countries, Diamondway.Countries.Country
  end

  @doc false
  def changeset(continent, attrs) do
    continent
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
