defmodule Diamondway.Repo.Migrations.MakeEmailsUnique do
  use Ecto.Migration

  def change do
    execute "create extension if not exists citext"

    execute "delete from guests where id = 43"

    alter table :guests do
      modify :email, :citext
    end
  end
end
