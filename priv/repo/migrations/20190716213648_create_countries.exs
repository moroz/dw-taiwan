defmodule Diamondway.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string, null: false
    end
  end
end
