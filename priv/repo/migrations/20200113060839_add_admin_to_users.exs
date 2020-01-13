defmodule Diamondway.Repo.Migrations.AddAdminToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :admin, :boolean, null: false, default: false
    end

    execute "update users set admin = true where human = true"
    execute "update audits set user_id = 1 where user_id > 3"
  end
end
