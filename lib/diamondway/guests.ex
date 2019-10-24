defmodule Diamondway.Guests do
  @moduledoc """
  The Guests context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo
  alias Diamondway.Guests.Guest

  def list_guests do
    Repo.all(from g in Guest, preload: [:residence, :nationality], order_by: [desc: :id])
  end

  def filter_and_paginate_guests(params) do
    Guest
    |> order_by([g], desc: :id)
    |> preload([g], [:residence, :nationality])
    |> Repo.paginate(params)
  end

  def count_guests(query \\ Guest) do
    from(g in query, select: count(g))
    |> Repo.one()
  end

  def preload_countries(guest) do
    Repo.preload(guest, [:residence, :nationality])
  end

  def get_guest!(id), do: Repo.get!(Guest, id)

  def get_guest(id), do: Repo.get(Guest, id) |> preload_countries()

  def send_confirmation_email(%{email_sent: true}), do: :noop

  def send_confirmation_email(guest) do
    {:ok, _ref} =
      guest
      |> DiamondwayWeb.RegistrationEmail.confirmation()
      |> DiamondwayWeb.Mailer.deliver()

    mark_email_sent(guest)
  end

  def mark_email_sent(%{email_sent: true}), do: :noop

  def mark_email_sent(guest) do
    guest
    |> Guest.changeset(%{email_sent: true})
    |> Repo.update()
  end

  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.registration_changeset(attrs)
    |> Repo.insert()
  end

  def create_guest_and_send_email(attrs \\ %{}) do
    with {:ok, guest} <- create_guest(attrs) do
      Task.start(fn ->
        send_confirmation_email(guest)
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
