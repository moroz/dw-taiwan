defmodule Diamondway.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :body, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :guest_id, references(:guests, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:notes, [:user_id])
    create index(:notes, [:guest_id])
  end
end
