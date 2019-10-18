defmodule Diamondway.Repo.Migrations.CreateAudits do
  use Ecto.Migration

  def change do
    create table(:audits) do
      add :timestamp, :utc_datetime, null: false, default: fragment("(now() at time zone 'utc')")
      add :description, :text, null: false
      add :guest_id, references(:guests, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :nilify_all), null: false
    end

    create index(:audits, [:guest_id])
    create index(:audits, [:user_id])
  end
end
