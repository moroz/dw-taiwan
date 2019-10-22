defmodule DiamondwayWeb.GraphQL.GuestMutationTest do
  use DiamondwayWeb.GraphQLCase, schema: DiamondwayWeb.GraphQL.Schema

  setup do
    guest = insert(:guest)
    user = insert(:user)
    [guest: guest, user: user]
  end

  @mutation """
  mutation transitionGuestState($id: ID!, $toState: GuestStatus!) {
    transition(id: $id, toState: $toState) {
      success
      message
      guest {
        id
        status
      }
    }
  }
  """
  test "changes status to verified when called with correct params", %{user: user, guest: guest} do
    assert guest.status == :unverified

    %{"transition" => %{"success" => true, "guest" => res}} =
      run_with_user(@mutation, user, %{id: guest.id, to_state: :verified})

    assert res["status"] == "VERIFIED"
    actual = reload(guest)
    assert actual.status == :verified
  end
end
