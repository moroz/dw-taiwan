defmodule Diamondway.Repo.Migrations.AssociateCountriesWithContinents do
  use Ecto.Migration

  def change do
    alter table :countries do
      add :continent_id, references(:continents)
    end
  end
end
