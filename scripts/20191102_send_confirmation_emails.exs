import Ecto.Query
alias Diamondway.Guests
alias Diamondway.Guests.Guest

guests = from(g in Guest, where: g.status == ^:invited, order_by: g.id) |> Repo.all()

for guest <- guests do
  Guests.send_confirmation_email(guest)
end
