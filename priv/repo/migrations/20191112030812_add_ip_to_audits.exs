defmodule Diamondway.Repo.Migrations.AddIpToAudits do
  use Ecto.Migration

  def change do
    alter table(:audits) do
      add :ip, :inet
    end
  end
end
