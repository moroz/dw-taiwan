defmodule Diamondway.Repo.Migrations.AddConfirmationEmailToGuests do
  use Ecto.Migration

  def change do
    rename table(:guests), :email_sent, to: :registration_sent

    alter table(:guests) do
      add :confirmation_sent, :boolean, null: false, default: false
      add :payment_sent, :boolean, null: false, default: false
    end
  end
end
