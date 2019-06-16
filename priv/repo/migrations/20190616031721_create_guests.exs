defmodule Diamondway.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :country, :string
      add :city, :string
      add :reference_name, :string
      add :reference_email, :string

      timestamps()
    end

    create unique_index(:guests, [:email])
  end
end
