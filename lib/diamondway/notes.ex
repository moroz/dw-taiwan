defmodule Diamondway.Notes do
  @moduledoc """
  The Notes context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo

  alias Diamondway.Users.User
  alias Diamondway.Guests.Guest
  alias Diamondway.Notes.Note

  def list_guest_notes(%Guest{} = guest) do
    from(g in Guest, where: g.id == ^guest.id)
    |> join(:inner, [g], n in assoc(g, :admin_notes))
    |> join(:inner, [g, n], u in assoc(n, :user))
    |> order_by([g, n], desc: n.inserted_at)
    |> select([g, n, u], %{
      timestamp: n.inserted_at,
      body: n.body,
      user_name: u.display_name,
      guest_name: fragment("? || ' ' || ?", g.first_name, g.last_name)
    })
    |> Repo.all()
  end

  def create_guest_note(%Guest{id: guest_id}, %User{id: user_id}, body) do
    %Note{}
    |> Note.changeset(%{guest_id: guest_id, user_id: user_id, body: body})
    |> Repo.insert()
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end
end
