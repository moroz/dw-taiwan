defmodule Diamondway.Guests do
  @moduledoc """
  The Guests context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo
  alias Diamondway.Guests.Guest
  alias Diamondway.Emails
  alias Diamondway.Audits

  def list_guests do
    Repo.all(from g in Guest, preload: [:residence, :nationality], order_by: [desc: :id])
  end

  def filter_and_paginate_guests(params) do
    Guest
    |> order_by([g], desc: :id)
    |> preload([g], [:residence, :nationality])
    |> filter_by_params(params)
    |> Repo.paginate(params)
  end

  defp filter_by_params(query, params) do
    Enum.reduce(params, query, &do_filter_params/2)
  end

  defp do_filter_params({:term, term}, query) when term != "" and is_binary(term) do
    phrase = "%#{term}%"

    query
    |> where(
      [g],
      fragment("unaccent(? || ' ' || ?) ilike unaccent(?)", g.first_name, g.last_name, ^phrase) or
        fragment("unaccent(?) ilike unaccent(?)", g.city, ^phrase) or ilike(g.email, ^phrase)
    )
  end

  defp do_filter_params({:status, status}, query) when not is_nil(status) do
    from(g in query, where: g.status == ^status)
  end

  defp do_filter_params(_, query), do: query

  def count_guests(query \\ Guest) do
    from(g in query, select: count(g))
    |> Repo.one()
  end

  def preload_countries(guest) do
    Repo.preload(guest, [:residence, :nationality])
  end

  def get_guest_by_payment_token(token) do
    Repo.get_by!(Guest, payment_token: token)
  end

  def mark_paid(%Guest{} = guest, ip) do
    Repo.transaction(fn ->
      update_guest(guest, %{paid_at: Timex.now(), status: :paid})
      Audits.create_guest_audit(guest, 4, "accepted payment.", ip)
    end)
  end

  def get_guest_by_email(email) do
    trimmed = String.trim(email)

    if EmailTldValidator.email_valid?(trimmed) do
      Repo.get_by(Guest, email: trimmed)
    else
      nil
    end
  end

  def get_waiting_list_number(%Guest{status: :backup} = guest) do
    from(g in Guest, where: g.id < ^guest.id)
    |> where([g], g.status == ^:backup)
    |> select([g], count(g) + 1)
    |> Repo.one()
  end

  def get_waiting_list_number(_), do: nil

  def get_guest!(id), do: Repo.get!(Guest, id)

  def get_guest(id), do: Repo.get(Guest, id) |> preload_countries()

  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.registration_changeset(attrs)
    |> Repo.insert()
  end

  def create_guest_and_send_email(attrs \\ %{}) do
    with {:ok, guest} <- create_guest(attrs) do
      Task.start(Emails, :send_email, [:registration, guest, 1])
      {:ok, guest}
    end
  end

  def update_guest(%Guest{} = guest, attrs) do
    guest
    |> Guest.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_guest(%Guest{} = guest) do
    Repo.delete(guest)
  end

  def change_guest(%Guest{} = guest) do
    Guest.changeset(guest, %{})
  end
end
