defmodule Diamondway.TicketingTest do
  use Diamondway.DataCase

  alias Diamondway.Ticketing

  describe "tickets" do
    alias Diamondway.Ticketing.Ticket

    @valid_attrs %{amount: "some amount", invoiced_at: ~N[2010-04-17 14:00:00], type: 42}
    @update_attrs %{amount: "some updated amount", invoiced_at: ~N[2011-05-18 15:01:01], type: 43}
    @invalid_attrs %{amount: nil, invoiced_at: nil, type: nil}

    def ticket_fixture(attrs \\ %{}) do
      {:ok, ticket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ticketing.create_ticket()

      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Ticketing.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Ticketing.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Ticketing.create_ticket(@valid_attrs)
      assert ticket.amount == "some amount"
      assert ticket.invoiced_at == ~N[2010-04-17 14:00:00]
      assert ticket.type == 42
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ticketing.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{} = ticket} = Ticketing.update_ticket(ticket, @update_attrs)
      assert ticket.amount == "some updated amount"
      assert ticket.invoiced_at == ~N[2011-05-18 15:01:01]
      assert ticket.type == 43
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Ticketing.update_ticket(ticket, @invalid_attrs)
      assert ticket == Ticketing.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Ticketing.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Ticketing.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Ticketing.change_ticket(ticket)
    end
  end
end
