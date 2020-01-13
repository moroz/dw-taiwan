defmodule Diamondway.UsersTest do
  use Diamondway.DataCase

  alias Diamondway.Users

  describe "permissions" do
    test "admin can do anything to anyone" do
      admin = insert(:admin)

      params = %{
        id: insert(:user)
      }

      assert Bodyguard.permit(Users, :create_user, admin, %{})
      assert Bodyguard.permit(Users, :list_users, admin, %{})
      assert Bodyguard.permit(Users, :update_user, admin, params)
      assert Bodyguard.permit(Users, :delete_user, admin, params)
      assert Bodyguard.permit(Users, :change_user, admin, params)
    end

    test "ordinary user can modify oneself and nothing else" do
      user = insert(:user)

      params = %{
        id: user.id
      }

      other_params = %{
        id: insert(:user)
      }

      refute Bodyguard.permit?(Users, :create_user, user, %{})
      refute Bodyguard.permit?(Users, :create_user, user, params)
      refute Bodyguard.permit?(Users, :list_users, user, params)
      refute Bodyguard.permit?(Users, :update_user, user, other_params)
      refute Bodyguard.permit?(Users, :delete_user, user, other_params)

      assert Bodyguard.permit?(Users, :update_user, user, params)
      assert Bodyguard.permit?(Users, :delete_user, user, params)
      assert Bodyguard.permit?(Users, :change_user, user, params)
    end
  end
end
