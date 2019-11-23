defmodule Diamondway.Repo.Migrations.RemovePaymentTokenFromGuests do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      remove :payment_token, :string
    end
  end
end
