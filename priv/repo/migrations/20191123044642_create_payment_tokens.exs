defmodule Diamondway.Repo.Migrations.CreatePaymentTokens do
  use Ecto.Migration

  def change do
    create table(:payment_tokens, id: false) do
      add :token, :string, null: false
      add :guest_id, references(:guests, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:payment_tokens, [:token])

    execute "insert into payment_tokens (token, guest_id, inserted_at, updated_at) select payment_token, id, now() at time zone 'UTC', now() at time zone 'UTC' from guests where payment_token is not null order by guests.id"
  end

  def down do
    drop table(:payment_tokens)
  end
end
