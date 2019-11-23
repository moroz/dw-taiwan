defmodule Diamondway.Payments.PaymentToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment_tokens" do
    field :token, :string, autogenerate: {__MODULE__, :generate_token, []}
    belongs_to :guest, Diamondway.Guests.Guest

    timestamps()
  end

  def generate_token(bytes \\ 10) do
    :crypto.strong_rand_bytes(bytes)
    |> Base.encode16(case: :lower)
  end

  @doc false
  def changeset(payment_token, attrs) do
    payment_token
    |> cast(attrs, [:guest_id])
    |> validate_required([:guest_id])
    |> unique_constraint(:token)
  end
end
