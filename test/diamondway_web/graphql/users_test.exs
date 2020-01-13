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

  @query """
  { listUsers { id displayName email avatarUrl human admin } }
  """
  describe "listUsers query" do
    test "returns list of users when called as admin" do
      insert(:user)
      me = insert(:admin)

      %{"listUsers" => actual} = run_with_user(@query, me)
      assert length(actual) == 2
    end

    test "denies access when called as regular user" do
      insert(:admin)
      me = insert(:user)

      actual = run_with_user(@query, me)
      refute actual["listUsers"]
    end
  end
end
