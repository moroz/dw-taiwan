defmodule DiamondwayWeb.GraphQL.NotesTest do
  use DiamondwayWeb.GraphQLCase, schema: DiamondwayWeb.GraphQL.Schema

  @mutation """
  mutation createNote($guestId: ID!, $body: String!) {
    createNote(guestId: $guestId, body: $body) {
      success
      guest {
        id
        adminNotes {
          body timestamp userName guestName
        }
      }
    }
  }
  """

  describe "createNote mutation" do
    test "creates note with valid params" do
      user = insert(:user, display_name: "John Paul II")
      guest = insert(:guest, first_name: "Karol", last_name: "Wojtyła")
      params = %{guest_id: guest.id, body: "Habemus papam!!!"}
      %{"createNote" => res} = run_with_user(@mutation, user, params)
      %{"success" => true, "guest" => %{"adminNotes" => [actual]}} = res
      assert actual["guestName"] == "Karol Wojtyła"
      assert actual["userName"] == "John Paul II"
      assert actual["body"] == params.body
    end
  end
end
