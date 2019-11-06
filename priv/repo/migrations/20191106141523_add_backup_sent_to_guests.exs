defmodule Diamondway.Repo.Migrations.AddBackupSentToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :backup_sent, :boolean, default: false, null: false
    end
  end
end
