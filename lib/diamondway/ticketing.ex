defmodule Diamondway.Ticketing do
  @moduledoc """
  The Ticketing context.
  """

  import Ecto.Query, warn: false
  alias Diamondway.Repo

  alias Diamondway.Ticketing.Ticket

  def list_tickets do
    Repo.all(Ticket)
  end

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  def change_ticket(%Ticket{} = ticket) do
    Ticket.changeset(ticket, %{})
  end
end
