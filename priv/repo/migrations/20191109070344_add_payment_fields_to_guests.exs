defmodule Diamondway.Repo.Migrations.AddPaymentFieldsToGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :payment_token, :string
      add :paid_at, :utc_datetime
    end

    create unique_index(:guests, [:payment_token], where: "payment_token is not null")
  end
end
