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

  def create_guest_audit(%Guest{} = guest, %User{} = user, description) do
    %{guest_id: guest.id, user_id: user.id, description: description}
    |> create_audit()
  end

  def list_guest_audits(%Guest{id: guest_id}) do
    Audit
    |> where([a], a.guest_id == ^guest_id)
    |> order_by([a], desc: :id)
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
