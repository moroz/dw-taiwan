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
        audits {
          guestName userName description timestamp
        }
        adminNotes {
          guestName userName body timestamp
        }
      }
    }
  }
  """

  describe "guests query" do
    test "returns no records when there are none" do
      %{"guests" => %{"entries" => []}} = run_query(@query)
    end

    test "returns guests from the database" do
      poland = insert(:country, name: "Poland")
      italy = insert(:country, name: "Italy")
      argentina = insert(:country, name: "Argentina")

      jan =
        insert(:guest,
          first_name: "Jan",
          last_name: "Paweł II",
          nationality: poland,
          residence: italy
        )

      frank =
        insert(:guest,
          first_name: "Francis",
          last_name: "Bergoglio",
          nationality: argentina,
          residence: italy
        )

      %{"guests" => %{"entries" => [francis, jp]}} = run_query(@query)

      assert jp["id"] == to_string(jan.id)
      assert jp["firstName"] == "Jan"
      assert jp["lastName"] == "Paweł II"
      assert jp["residence"] == "Italy"
      assert jp["nationality"] == "Poland"

      assert francis["id"] == to_string(frank.id)
      assert francis["firstName"] == "Francis"
      assert francis["lastName"] == "Bergoglio"
      assert francis["residence"] == "Italy"
      assert francis["nationality"] == "Argentina"
    end
  end
end
