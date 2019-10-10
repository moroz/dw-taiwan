defmodule DiamondwayWeb.GraphQL.GuestsTest do
  use DiamondwayWeb.GraphQLCase, schema: DiamondwayWeb.GraphQL.Schema

  @query """
  {
    guests {
      cursor {
        totalEntries
      }
      entries {
        id firstName lastName phone email city
        residence nationality
      }
    }
  }
  """

  describe "guests query" do
    test "returns no records when there are none" do
      %{"guests" => %{"entries" => []}} = run_query(@query)
    end

    test "returns guests from the database" do
      jan = insert(:guest, first_name: "Jan", last_name: "Paweł II")
      frank = insert(:guest, first_name: "Francis", last_name: "Bergoglio")
      %{"guests" => guests} = run_query(@query)
    end
  end
end
