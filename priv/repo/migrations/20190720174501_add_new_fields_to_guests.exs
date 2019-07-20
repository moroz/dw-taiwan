defmodule Diamondway.Repo.Migrations.AddNewFieldsToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      remove :country, :string
      add :nationality_id, references(:countries)
      add :residence_id, references(:countries)
      add :sex, :integer, null: false
      add :phone, :string
    end
  end
end
