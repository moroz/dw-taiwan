defmodule Diamondway.Repo.Migrations.CreateContinents do
  use Ecto.Migration

  def change do
    create table(:continents) do
      add :name, :string
    end

    create unique_index(:continents, [:name])
  end
end
