defmodule Diamondway.Ticketing.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  @prices %{
    full: 4800,
    single: 600
  }

  schema "tickets" do
    field :amount, :integer, default: 4800
    field :invoiced_at, :naive_datetime
    field :type, :integer
    field :user_id, :id
    field :guest_id, :id

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:type, :invoiced_at, :user_id, :guest_id])
    |> validate_required([:type, :user_id, :guest_id])
  end
end
