defmodule Diamondway.Ticketing.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Diamondway.Ticketing.Prices

  schema "tickets" do
    field :amount, :integer
    field :invoiced_at, :utc_datetime
    field :type, Diamondway.Enums.TicketType
    belongs_to :user, Diamondway.Users.User
    belongs_to :guest, Diamondway.Guests.Guest

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:type, :invoiced_at, :user_id, :guest_id])
    |> validate_required([:type, :user_id, :guest_id])
    |> set_amount()
  end

  defp set_amount(changeset) do
    case get_field(changeset, :amount) do
      nil ->
        type = get_field(changeset, :type)
        price = Prices.price(type)
        put_change(changeset, :amount, price)

      _ ->
        changeset
    end
  end
end
