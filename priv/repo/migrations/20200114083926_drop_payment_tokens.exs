defmodule Diamondway.Repo.Migrations.DropPaymentTokens do
  use Ecto.Migration

  def change do
    drop table(:payment_tokens)
  end
end
