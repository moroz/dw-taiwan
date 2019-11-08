defmodule Diamondway.Repo.Migrations.AddUnaccentExtension do
  use Ecto.Migration

  def change do
    execute "create extension if not exists unaccent with schema public"
  end
end
