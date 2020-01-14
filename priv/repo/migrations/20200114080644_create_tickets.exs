defmodule Diamondway.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :type, :integer, null: false
      add :amount, :integer, null: false, default: 4800
      add :invoiced_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :guest_id, references(:guests, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:tickets, [:user_id])
    create index(:tickets, [:guest_id])
  end
end
