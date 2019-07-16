defmodule Diamondway.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :name, :string
  end
end
