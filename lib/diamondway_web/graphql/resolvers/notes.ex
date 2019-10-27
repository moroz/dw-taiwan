defmodule DiamondwayWeb.GraphQL.Resolvers.Notes do
  alias Diamondway.Notes
  alias Diamondway.Guests

  def create_guest_note(%{guest_id: guest_id, body: body}, %{context: %{current_user: user}}) do
    guest = Guests.get_guest!(guest_id)

    with {:ok, _note} <-
           Notes.create_guest_note(guest, user, body) do
      {:ok, %{success: true, guest: Guests.preload_countries(guest)}}
    end
  end
end
