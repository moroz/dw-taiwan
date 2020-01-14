defmodule Diamondway.TicketingTest do
  use Diamondway.DataCase

  alias Diamondway.Ticketing
  alias Diamondway.Ticketing.Prices

  describe "create_ticket/1" do
    test "creates ticket with valid params" do
      params = params_with_assocs(:ticket)
      assert {:ok, ticket} = Ticketing.create_ticket(params)
    end

    test "does not create ticket without :type" do
      params = params_with_assocs(:ticket, type: nil)
      assert {:error, changeset} = Ticketing.create_ticket(params)
    end

    test "sets correct price based on type" do
      params = params_with_assocs(:ticket, type: :full)
      {:ok, full} = Ticketing.create_ticket(params)
      assert full.amount == Prices.price(:full)

      single_params = params_with_assocs(:ticket, type: :single)
      {:ok, single} = Ticketing.create_ticket(single_params)
      assert single.amount == Prices.price(:single)
    end
  end
end
