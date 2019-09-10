defmodule Diamondway.Guests do
  @moduledoc """
  The Guests context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo

  alias Diamondway.Guests.Guest

  def list_guests do
    Repo.all(from g in Guest, preload: [:residence, :nationality])
  end

  def preload_countries(guest) do
    Repo.preload(guest, [:residence, :nationality])
  end

  def get_guest!(id), do: Repo.get!(Guest, id)

  def send_confirmation_email(guest) do
    guest
    |> DiamondwayWeb.RegistrationEmail.confirmation()
    |> DiamondwayWeb.Mailer.deliver()
  end

  def create_guest(attrs \\ %{}) do
    %Guest{}
    |> Guest.changeset(attrs)
    |> Repo.insert()
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
