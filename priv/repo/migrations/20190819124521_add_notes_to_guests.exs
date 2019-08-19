defmodule Diamondway.Repo.Migrations.AddNotesToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :notes, :text
    end
  end
end
