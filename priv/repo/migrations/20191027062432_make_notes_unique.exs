defmodule Diamondway.Repo.Migrations.MakeNotesUnique do
  use Ecto.Migration

  def change do
    create unique_index(:notes, [:guest_id, :body])
  end
end
