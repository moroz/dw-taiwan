defmodule Diamondway.GuestsTest do
  use Diamondway.DataCase

  alias Diamondway.Guests

  describe "guests" do
    alias Diamondway.Guests.Guest

    @valid_attrs %{city: "some city", country: "some country", email: "some email", first_name: "some first_name", last_name: "some last_name", reference_email: "some reference_email", reference_name: "some reference_name"}
    @update_attrs %{city: "some updated city", country: "some updated country", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", reference_email: "some updated reference_email", reference_name: "some updated reference_name"}
    @invalid_attrs %{city: nil, country: nil, email: nil, first_name: nil, last_name: nil, reference_email: nil, reference_name: nil}

    def guest_fixture(attrs \\ %{}) do
      {:ok, guest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Guests.create_guest()

      guest
    end

    test "list_guests/0 returns all guests" do
      guest = guest_fixture()
      assert Guests.list_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Guests.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      assert {:ok, %Guest{} = guest} = Guests.create_guest(@valid_attrs)
      assert guest.city == "some city"
      assert guest.country == "some country"
      assert guest.email == "some email"
      assert guest.first_name == "some first_name"
      assert guest.last_name == "some last_name"
      assert guest.reference_email == "some reference_email"
      assert guest.reference_name == "some reference_name"
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guests.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{} = guest} = Guests.update_guest(guest, @update_attrs)
      assert guest.city == "some updated city"
      assert guest.country == "some updated country"
      assert guest.email == "some updated email"
      assert guest.first_name == "some updated first_name"
      assert guest.last_name == "some updated last_name"
      assert guest.reference_email == "some updated reference_email"
      assert guest.reference_name == "some updated reference_name"
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Guests.update_guest(guest, @invalid_attrs)
      assert guest == Guests.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Guests.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Guests.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Guests.change_guest(guest)
    end
  end
end
