defmodule Diamondway.Repo.Migrations.AddEmailSentToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :email_sent, :boolean, null: false, default: false
    end

    create index(:guests, [:email_sent])
  end
end
