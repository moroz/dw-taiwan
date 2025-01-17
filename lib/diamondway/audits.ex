defmodule Diamondway.Audits do
  @moduledoc """
  The Audits context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo

  alias Diamondway.Audits.Audit
  alias Diamondway.Guests.Guest
  alias Diamondway.Users.User

  def list_audits do
    Repo.all(Audit)
  end

  def get_audit!(id), do: Repo.get!(Audit, id)

  def create_guest_audit(guest, user, description, ip \\ nil)

  def create_guest_audit(%Guest{} = guest, %User{} = user, description, ip) do
    create_guest_audit(guest, user.id, description, ip)
  end

  def create_guest_audit(%Guest{} = guest, user_id, description, ip)
      when is_integer(user_id) do
    %{guest_id: guest.id, user_id: user_id, description: description, ip: ip}
    |> create_audit()
  end

  def list_guest_audits(%Guest{id: guest_id}) do
    Audit
    |> where([a], a.guest_id == ^guest_id)
    |> order_by([a], desc: :id)
    |> join(:inner, [a], u in assoc(a, :user))
    |> join(:inner, [a], g in assoc(a, :guest))
    |> select([a, u, g], %{
      timestamp: a.timestamp,
      description: a.description,
      guest_name: fragment("? || ' ' || ?", g.first_name, g.last_name),
      user_name: u.display_name,
      ip: fragment("case when ? is not null then host(?) end", a.ip, a.ip)
    })
    |> Repo.all()
  end

  def create_audit(attrs \\ %{}) do
    %Audit{}
    |> Audit.changeset(attrs)
    |> Repo.insert()
  end

  def update_audit(%Audit{} = audit, attrs) do
    audit
    |> Audit.changeset(attrs)
    |> Repo.update()
  end

  def delete_audit(%Audit{} = audit) do
    Repo.delete(audit)
  end

  def change_audit(%Audit{} = audit) do
    Audit.changeset(audit, %{})
  end
end
