defmodule DiamondwayWeb.GraphQL.UsersTest do
  use DiamondwayWeb.GraphQLCase, schema: DiamondwayWeb.GraphQL.Schema

  @query """
  {
    currentUser {
      id displayName email
    }
  }
  """

  describe "currentUser query" do
    test "returns current user" do
      me = insert(:user)
      %{"currentUser" => actual} = run_with_user(@query, me)

      assert actual["id"] == to_string(me.id)
      assert actual["email"] == me.email
      assert actual["displayName"] == me.display_name
    end
  end
end
