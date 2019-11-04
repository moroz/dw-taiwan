defmodule Diamondway.Guests do
  @moduledoc """
  The Guests context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo
  alias Diamondway.Audits
  alias Diamondway.Guests.Guest
  alias Diamondway.Users.User
  alias DiamondwayWeb.RegistrationEmail
  alias DiamondwayWeb.Mailer

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

  def get_guest!(id), do: Repo.get!(Guest, id)

  def get_guest(id), do: Repo.get(Guest, id) |> preload_countries()

  defp email_allowed?(type, guest)
  defp email_allowed?(:registration, _), do: true
  defp email_allowed?(_, guest), do: guest.status == :invited

  @email_types ~w(registration payment confirmation)a
  def send_email(type, guest, user, force) when type in @email_types do
    if email_sent?(guest, type) || force do
      case email_allowed?(type, guest) do
        true ->
          do_send_email(type, guest, user)

        _ ->
          {:error, :illegal_email_type}
      end
    end
  end

  defp do_send_email(type, guest, user) do
    Repo.transaction(fn ->
      email = RegistrationEmail.render_email(type, guest)

      case Mailer.deliver_and_catch(email) do
        {:ok, _ref} ->
          {:ok, updated} = mark_email_sent(guest, type)
          Audits.create_guest_audit(guest, user, "sent out #{type} e-mail.")
          preload_countries(updated)

        error ->
          Audits.create_guest_audit(guest, user, "#{type} email delivery failed.")
          error
      end
    end)
  end

  defp email_sent?(guest, email_type) when email_type in @email_types do
    field = :"#{email_type}_sent"
    Map.get(guest, field)
  end

  def mark_email_sent(guest, email_type) do
    if email_sent?(guest, email_type) do
      {:ok, guest}
    else
      attrs = Map.new([{"#{email_type}_sent", true}])

      Guest.changeset(guest, attrs)
      |> Repo.update()
    end
  end

  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.registration_changeset(attrs)
    |> Repo.insert()
  end

  def create_guest_and_send_email(attrs \\ %{}) do
    with {:ok, guest} <- create_guest(attrs) do
      Task.start(fn ->
        do_send_email(:registration, guest, 1)
      end)

      {:ok, guest}
    end
  end

  def update_guest(%Guest{} = guest, attrs) do
    guest
    |> Guest.changeset(attrs)
    |> Repo.update()
  end

  def delete_guest(%Guest{} = guest) do
    Repo.delete(guest)
  end

  def change_guest(%Guest{} = guest) do
    Guest.changeset(guest, %{})
  end
end
