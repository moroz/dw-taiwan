defmodule Diamondway.Repo.Migrations.MakePasswordDigestNullableInUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password_hash, :string, null: true
      add :human, :boolean, null: false, default: true
    end
  end
end
