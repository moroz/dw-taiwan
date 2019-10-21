defmodule Diamondway.Repo.Migrations.AddStatusToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :status, :integer, null: false, default: 0
    end
  end
end
